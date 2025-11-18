import React, {Fragment, useContext, useState} from 'react'
import { AppContext } from '../../../AppContext'
import plusBox from '../../../assets/images/plus-box.png'
import minusBox from '../../../assets/images/minus-box.png'
import emptyNode from '../../../assets/images/empty-node.png'
import IconButton from '../buttons/IconButton'
import icons from '../../../shared/icons'
import './TreeBrowser.css'

//var categories = [
                    // {idParent: 1, idCategory: 9, catDesc: 'Accounting/Finance', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 10, catDesc: 'Animals', selected: false, expanded: false, children:
                    //     [{idParent: 10, idCategory: 110, catDesc: 'Dogs', selected: false, expanded: false},
                    //     {idParent: 10, idCategory: 111, catDesc: 'Cats', selected: false, expanded: false},
                    //     {idParent: 10, idCategory: 112, catDesc: 'Horses', selected: false, expanded: false}]
                    // },
                    // {idParent: 1, idCategory: 11, catDesc: 'Appliances', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 12, catDesc: 'Arts', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 13, catDesc: 'Automotive', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 14, catDesc: 'Books', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 15, catDesc: 'Children/Babies', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 16, catDesc: 'Clothes/Fashion', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 17, catDesc: 'Construction/Contracting', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 18, catDesc: 'Electronics', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 19, catDesc: 'Employment', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 20, catDesc: 'Health/Beauty', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 21, catDesc: 'Home Improvement', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 22, catDesc: 'Movies/T.V.', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 23, catDesc: 'Music', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 24, catDesc: 'Office/Business', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 25, catDesc: 'Real Estate/Housing', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 26, catDesc: 'Sports/Fitness', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 27, catDesc: 'Technology/IT', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 28, catDesc: 'Tickets', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 29, catDesc: 'Toys/Games', selected: false, expanded: false},
                    // {idParent: 1, idCategory: 30, catDesc: 'Video Games', selected: false, expanded: false}
               // ]

// var demoData = [{idParent: null, idCategory: 1, catDesc: 'Items', selected: false, expanded: false, children: categories},
//                   {idParent: null, idCategory: 2, catDesc: 'Services', selected: false, expanded: false, children: categories}]

const TreeBrowser = (props) => {

    const {appContext} = useContext(AppContext)
    const [otherCategory, setOtherCategory] = useState([' '])

    const updateOtherCategory = (index, suggestion) => {
        let newOtherCategory = [...otherCategory]
        newOtherCategory[index] = suggestion
        setOtherCategory(newOtherCategory)
    }
    
    const findCategory = (siblings, idCategory ) => {
        var index = null
        siblings.forEach(element => {
            if (!index)
                if (element.idCategory === idCategory) index = element
                else if (element.children) index = findCategory(element.children, idCategory)
        });
        return index
    }

    const expandNode = (isExpanded, idCategory) => {
        var newData = [...props.data]
        var index = findCategory( newData, idCategory)
        //let index = newData.find(c => c.idCategory === idCategory)
        if (index) {
            index.expanded = isExpanded
            props.setData(newData)
        }
    }

    const treeSiblings = (siblingData, level) => {
        return (
            <div className = 'tree-browser-siblings-container'>
                {siblingData.map((row, index) => {
                    return (
                    <Fragment key={row.idCategory}>
                        {treeLine(row, level)}
                        {row.expanded ? treeSiblings(row.children, level + 1) : ''}
                    </Fragment>)
                })}
            </div>
        )
    }

    const treeLine = (row, level) => {
        if (row.children)
            return (
                <div className = 'tree-line'>
                    {row.children.length > 0 ?
                        (row.expanded ? 
                            <img className='expand-box' src={minusBox}
                                onClick={()=>expandNode(false, row.idCategory)} alt='collapse'/> 
                            : 
                            <img className='expand-box' src={plusBox}
                                onClick={()=>expandNode(true, row.idCategory)} alt='expand'/>)
                        :
                        <div className='checkbox-spacer'></div>
                    }
                    {row.catDesc.substring(0,5) !== 'Other' ?
                        <Fragment>
                            <input className='tree-checkbox' type='checkbox' checked={row.selected} 
                                onChange={()=>updateSelected(row.idCategory)}/>
                            <div className='tree-line-inside'>{row.catDesc}
                            </div>
                        </Fragment>
                    :
                        <Fragment>
                            <div className='checkbox-spacer'></div>
                            <div className='tree-line-inside-other'>
                                <div className='other-container'>{row.catDesc}</div>
                                <input className='tree-input-other' type='text' value={otherCategory[row.idCategory]} onChange={(event)=>{updateOtherCategory(row.idCategory,event.target.value)}}/>
                                <IconButton styleName='add-button small margin-top-button' 
                                    caption='Add Category' src={icons.addIcon} disabled={checkEmptyInput(row.idCategory)} onClick={()=>addCategory(row.idParent, level, row.idCategory)}></IconButton>
                            </div>
                        </Fragment>}
                </div>
            )
        else
            return (
                <div className = 'tree-line'>
                    <img className='expand-box' src={emptyNode} alt='leaf'/>
                    <input className='tree-checkbox' type='checkbox'/>
                    {row.catDesc}
                </div>
            )
    }

    const checkEmptyInput = (id) => {
        if (otherCategory[id])
            return (otherCategory[id].length<1)
        else return true
    }

    const updateSelected = (idCategory) => {
        var newData = [...props.data]
        var index = findCategory( newData, idCategory)
        //let index = newData.find(c => c.idCategory === idCategory)
        if (index) {
            index.selected = !index.selected
            props.setData(newData)
        }
        props.updateSelected(idCategory, '')
    }

    const addCategory = (idParent, level, idOther) =>  {
        props.addCategory({idParent: idParent,
                        idCategory: null,
                        catDesc: otherCategory[idOther],
                        catLevel: level,
                        entityType: props.entityType,
                        idSuggestor: appContext.idEntity })
        updateOtherCategory(idOther,'')
    }

    return (
        <div className = 'tree-container'>
            {treeSiblings(props.data, 1)}
        </div>
    )

}

export default TreeBrowser
