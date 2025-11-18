import util from '../shared/util.js'
import config from '../config/appConfig.js'
import MediaCDO from './MediaCDO.js'
const cdoMedia = new MediaCDO()

let port = ""
if (config.server.webServicesPort !== 0) port = `:${config.server.webServicesPort}`
var servicesURL = `${config.server.url}${port}/user/`

export const ENTITY_TYPE = ['Entity', 'User', 'Person', 'Post', 'Item', 'Service','Event','Place','Group']
export const ENTITY_TYPE_LOWERCASE = ['entity', 'user', 'person', 'post', 'item', 'service','event','place','group']
export const ENTITY_TYPE_LOWERCASE_PLURAL = ['entities', 'users', 'people', 'posts', 'items', 'services','events','places','groups']
export const ENTITY_TYPE_PLURAL = ['Entities', 'Users', 'People', 'Posts', 'Items', 'Services','Events','Places','Groups']
export const ENTITY_USER = 1
export const ENTITY_PERSON = 2
export const ENTITY_POST = 3
export const ENTITY_ITEM = 4
export const ENTITY_SERVICE = 5
export const ENTITY_EVENT = 6
export const ENTITY_PLACE = 7
export const ENTITY_GROUP = 8

export const DEPOSIT_NOT_REQUIRED = 0
export const DEPOSIT_UPON_BOOKING = 1
export const DEPOSIT_UPON_CANCEL_LEAD = 2
export const DEPOSIT_BEFORE_SERVICE = 3


class EntityCDO {

   search = (data, callback) => {
      //data {idEntity, idSession, searchCriteria}
      util.putJSON(servicesURL, data, callback);
   }

   view = (data, callback) => {
      util.putJSON(servicesURL + 'view', data, callback);
   }

   loadData = (data, callback) => {
      //data {idEntity, idSession}
      util.putJSON(servicesURL + 'load', data, callback);
   }

   loadEntityMedia = (data, callback) => {
      cdoMedia.loadData(data, callback)
   }

   loadEntityContent = (data, callback) => {
      util.putJSON(servicesURL + 'load-content', data, callback);
   }

   loadEntityOwner = (data, callback) => {
      util.putJSON(servicesURL + 'load-owner', data, callback);
   }   
   
   loadEntityCategories = (data, callback) => {
      util.putJSON(servicesURL + 'load-categories', data, callback);
   }

   loadEntityOffer = (data, callback) => {
      util.putJSON(servicesURL + 'load-offer', data, callback);
   }

   loadEntityArea = (data, callback) => {
      util.putJSON(servicesURL + 'load-area', data, callback);
   }

   saveData = (data, callback) => {
      util.putJSON(servicesURL + 'update', data, callback);
   }

   addData = (data, callback) => {
      util.putJSON(servicesURL + 'add', data, callback);
   }

   verifyRelate = (data, callback) => {
      //data {idEntity, idRelated}
      util.putJSON(servicesURL + 'verify-relate', data, callback);
   }

   deleteData = (data, callback) => {
      util.putJSON(servicesURL + 'delete', data, callback);
   }

   getEmptyRow = () => {
      const newRow = { idEntity: null,
                       entityTitle: '',
                       entityDesc: '',
                       seeking: true,
                       content: [],
                       owned: [],
                       category: [],
                       attribute: [],
                       media: [],
                       rate: { idOffer: null,
                           price: 0,  // service rate
                           rateType: 2,  // 0 = flat fee, 1 = per 1/2 hour, 2 = per hour, 3 = per day
                           negotiable: false,
                           rateSetType: 0, // 0 = set your rate, 1 = negotiable 2 = free
                           new: true,                      
                           handlePayment: 1, // 0=false 1=true
                       },
                       offer: { idOffer: null,
                           offerType: 1, // 0 = not offered, 1 = offered
                           confirmMethod: 0, // 0 = manual, 1 = automatic
                           price: 0,  // service rate
                           rateType: 2,  // 0 = flat fee, 1 = per 1/2 hour, 2 = per hour, 3 = per day
                           negotiable: false,
                           quantify: true,
                           quantity: 1,
                           minTimeIncrement: 30,
                           maxTimeIncrement: 0,
                           startTimeIncrement: 0,
                           bookingLeadNumber: 1,
                           bookingLeadType: 1,
                           cancelLeadNumber: 24,
                           cancelLeadType: 1,  // 0 = mins, 1 = hours, 2 = days
                           cancelFee: 50,
                           cancelFeeType: 1,  // 0 = flat, 1 = percentage
                           cancelPolicyOn: 0,  
                           rateSetType: 0, // 0 = set your rate, 1 = negotiable, 2 = free
                           handlePayment: 1, // 0 = false, 1 = true
                           depositRequired: 0, // 0 = none, 1 = upon booking, 2 = upon cancel lead time, 3 = prior to service
                           depositAmountType: 0, // 0 = flat, 1 = percentage, 2 = equaltoCXL
                           depositAmount: 0,
                           serviceLocation: 0, // 0 = online, 1 = in-person, 2 = both
                           area: {
                              idAddress: 0,  // leave zero until more exact location than postalCode is implemented
                              postalCode: '',
                              mileRadius: 0
                           },
                        },
                       idUser: null,
                       idSession: null,
                       dirty: false,
                       new: true,
                       markedForDeletion: false
                     }
      return newRow;
  }

};

export default EntityCDO;