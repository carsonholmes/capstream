import React, { Fragment } from "react"
// uses styling from HelpIcon.css

const generateDropdownHelp = (data) => {
    return (
        <>
            {data.map((row, index)=> {
                return (
                    <Fragment key={row.description}>
                        <div className='help-item'>
                            <label className='bold-text'>{row.caption}</label>{' - '}<label>{row.description}</label> 
                        </div>
                    </Fragment>
                )
            })}
        </>
    )
}
    

export default generateDropdownHelp