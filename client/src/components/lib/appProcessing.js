//import cdoAI from '../../cdo/cdoAI.js';
import cdoProfile from '../../cdo/cdoProfile.js'

const mergeExtractedData = (prevData, newData) => {
    // Create a map from the first array to quickly lookup existing objects by dataName
    const map = new Map(prevData.map(item => [item.dataName, item]));

    // Iterate over the second array to merge new or updated objects
    newData.forEach(item => {
        if (map.has(item.dataName)) {
        // If dataName already exists, update the dataValue
            map.get(item.dataName).dataValue = item.dataValue;
        } else {
        // If dataName does not exist, add the new object
            map.set(item.dataName, item);
        }
    });

    // Convert the map back to an array
    return Array.from(map.values());
}

  /*
    * New
    * Register
    * Sign In
    * Sign In with Provider
    * Fund
    * Ready
    * Create
    * Load
    * Modify
  */

const appProcessing = (() => {

  let userData = {  
    idEntity: null,  //id of the user
    userNameOrEmail: null,
    password: null,
    userName: null,
    personFirstName: '',
    personLastName: '',
    userPassword: null,
    sixDigitCode: null,
    emailVerifyCode: null,
    alphaCode: null,
    accountBalance: 0
  };

  let sessionData = {
    sessionId: null
  }

  let appData = {}

  let factoryResponse = ""
  let setMessagesHandle = ()=>{}
  let setConversationStateHandle = ()=>{}
  let setExtractedDataHandle = ()=>{}
  let setUserEmailHandle = ()=>{}
  let setPasswordPopupHandle = ()=>{}
  let setAuthorizedUserHandle = ()=>{}
  let setUserDataHandle = ()=>{}
  let setAppDataHandle = ()=>{}
  let loadAppsHandle = ()=>{}

  const initialize = (setMessages, setConversationState, setExtractedData, setUserEmail, setPasswordPopup, setAuthorizedUser, setUserData, setAppData, loadApps) => {
    setMessagesHandle = setMessages
    setConversationStateHandle = setConversationState
    setExtractedDataHandle = setExtractedData
    setUserEmailHandle = setUserEmail
    setPasswordPopupHandle = setPasswordPopup
    setAuthorizedUserHandle = setAuthorizedUser
    setUserDataHandle = setUserData
    setAppDataHandle = setAppData
    loadAppsHandle = loadApps
  }

  const handleResponse = (response, messages, extractedData, userEmail, emailExists, componentUserData, componentAppData, session) => {
    userData = componentUserData
    appData = componentAppData
    const aiMessage = { text: response.factoryResponse, isUser: false };
    if (response.factoryAction || (response.extractedData && response.extractedData.length > 0)) {
      setConversationStateHandle( response.factoryAction )
      let alertMsg = "Factory Action: " + response.factoryAction + "\n\n"
      if (response.extractedData && response.extractedData.length > 0) {
        setExtractedDataHandle((prevData)=>mergeExtractedData(prevData,response.extractedData))
        response.extractedData.forEach( (e)=>{
          alertMsg += e.dataName + ": " + e.dataValue + "\n\n"
          if (e.dataName==="sixDigitCode" || 
              e.dataName==="alphaCode" || 
              e.dataName==="personFirstName" ||
              e.dataName==="personLastName" ||
              e.dataName==="fullName" ) 
            userData[e.dataName] = e.dataValue
        })
      }
      //alert(alertMsg);
      if (((response.factoryAction === "Sign In" && userEmail.length > 6) ||
          (response.factoryAction === "Register" && emailExists)) && !userData.idEntity) {
        userData.userNameOrEmail = userEmail
        setUserDataHandle( userData )
        setPasswordPopupHandle(2)  //login
      }
      if (response.factoryAction === "Resend") {
        cdoProfile.resendEmail( userData, (err, result)=>{
          if (err) {
            let sysResponse = result.response + "\n\n" + JSON.stringify(result.error)
            aiMessage.text = sysResponse
            setMessagesHandle((prevMessages) => [...prevMessages, aiMessage]);
          }
        })
      }
      if ((response.factoryAction === "Register" || response.factoryAction === "Fund") && 
          userData.sixDigitCode && userData.sixDigitCode.length>0 && !userData.emailVerified) {
        userData.emailVerifyCode = userData.sixDigitCode
        cdoProfile.verifyEmail( userData, (err, result)=>{
          if (err || result.response !== 'Verified') {
            aiMessage.text = result.error
          }
          if (!err && result.response === 'Verified') {
            userData.emailVerified = true
            if (userData.accountBalance && userData.accountBalance > 0) {
              aiMessage.text = "Your email account has been verified.  You can now use the factory to build software."
              loadAppsHandle(userData, [messages, aiMessage], session )
            } else {
              setConversationStateHandle("Fund")
              aiMessage.text = "Your email account has been verified.  Have you been invited to the Alpha program with a special code?"
            }
          }
          setMessagesHandle((prevMessages) => [...prevMessages, aiMessage])
        })
        setUserDataHandle( userData )
      }
      else if (response.factoryAction === "Fund" || response.factoryAction === "Ready") {
        if (userData.alphaCode && userData.alphaCode.length > 0) {
          console.log(userData)
          cdoProfile.useAlphaCode( userData, (err,response) => {
            console.log(response)
            if (!err && response.message==="Success") {
              aiMessage.text = "You account has been successfully funded."
              userData.accountBalance = response.accountBalance
              setUserDataHandle( userData )
            }
            else {
              aiMessage.text = "Alpha Program Code " + response.message
              setConversationStateHandle("Fund")
            }
            setMessagesHandle((prevMessages) => [...prevMessages, aiMessage])
          })
        }
        else setMessagesHandle((prevMessages) => [...prevMessages, aiMessage])
      }
      else {
        if (response.factoryAction === "Register" && !emailExists && 
            userData.fullName && userData.fullName.length > 0 &&
            userEmail.length > 6 && !userData.idEntity) {
          let newUserData = extractedData.reduce((accumulate, curr) => {
            accumulate[curr.dataName] = curr.dataValue;
            return accumulate;
          }, {});
          userData = {...userData, newUserData}
          userData.userName = userEmail //hard code user name to email address for now as userName is not being used
          userData.emailAddress = userEmail
          factoryResponse = response.factoryResponse
          setUserDataHandle( userData )
          setPasswordPopupHandle(1)  //create password
        }
        else {
          setMessagesHandle((prevMessages) => [...prevMessages, aiMessage]);
        }
      }
    }
  }

  const passwordSubmit = (mode, password, messages, session) => {
    const aiMessage = { text: '', isUser: false }
    userData.userPassword = password
    if (mode === 1) {     //Register
      //user just created password - call services to create entity, person, user, email, send verify email  
      cdoProfile.addProfile( userData, (err, result) => {
        if (!err) {
          aiMessage.text = factoryResponse
          setMessagesHandle((prevMessages) => [...prevMessages, aiMessage]);
          if (result.idEntity) {
            setUserDataHandle(result)
            setAuthorizedUserHandle(result.idEntity)
          }
        }
      })
    }
    else if (mode ===2) {  //Sign In
      cdoProfile.signIn( userData, (err, result)=> {
        if(!err) {
          //set user data
          if (result.response === "Success") {
            console.log(result)
            userData = {...result.user}
            setUserDataHandle(userData)
            //sessionData = {...result.session} - this is from userSession not session (current this userSession not being used)
            setAuthorizedUserHandle(userData.idEntity)
            if (userData.emailVerified) {
              if (userData.accountBalance && userData.accountBalance > 0) {
                setConversationStateHandle("Ready")
                aiMessage.text = "You have successfully logged in.  You can now use the factory to create software."
                loadAppsHandle(userData, [...messages, aiMessage], session )
              } else {
                setConversationStateHandle("Fund")
                aiMessage.text = "You have successfully logged in. \n\n Have you been invited to the Alpha Program with a special code?"
              }
            } else {
              setUserEmailHandle(userData.emailAddress)
              setConversationStateHandle("Register - with sub-state: Verify")
              aiMessage.text = "Your email has not been verified.  Please enter the six-digit code sent to valid@email.com or ask me to resend the email."
            }
            setMessagesHandle((prevMessages) => [...prevMessages, aiMessage])
          }
          else {
            aiMessage.text = "Your sign in attempt was unsuccessful with the credentials provided."
            setMessagesHandle((prevMessages) => [...prevMessages, aiMessage])
            setTimeout( setPasswordPopupHandle, 2000, 2)
          }
        }
      } )
    }
  }

  return {
    initialize,
    handleResponse,
    passwordSubmit
  };
})();

export default appProcessing;