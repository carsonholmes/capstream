import React, {useState, useEffect} from 'react'
import ContentContainer from '../ContentContainer/ContentContainer'
import Card from '../Card/Card'
import EntityList from '../EntityList/EntityList'
import './Results.css'
import EntityCDO from '../../cdos/EntityCDO'
var cdo = new EntityCDO()

const Results = (props) => {

    const [data, setData] = useState([])
    const [dataLoaded, setDataLoaded] = useState(false)
            
    useEffect(()=>{
        if (cdo && !dataLoaded) {
            setDataLoaded(true)
            cdo.search(props.searchCriteria, cbLoadData)
        }
    }, [props.searchCriteria, dataLoaded])

    const cbLoadData = (error, dbData) => {
        if (!error)
            if (!dbData.error) {
                let newData = []
                for (var x = 0; x < dbData.length; x++) {
                    newData[x] = dbData[x]
                }
                setData(newData)
            }
            else alert(`Error ${dbData.error.errno} loading data.  ${dbData.error.code} ${dbData.error.sqlMessage}`)
  }

    return (
        <ContentContainer>
            <Card cardHeading='Search Results'>
                for {'\''}{props.searchCriteria.searchValue}{'\''}
                <br/>
                <hr/>
                <EntityList data={data}></EntityList>
            </Card>
        </ContentContainer>
    )
}

export default Results