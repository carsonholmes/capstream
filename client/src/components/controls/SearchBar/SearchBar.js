import React, {useState} from 'react'
import './SearchBar.css'
import searchIcon from '../../../assets/images/search.png'

const SearchBar = (props) => {

    const [searchValue, setSearchValue] = useState('')

    const updateSearch = (event) => {
        setSearchValue(event.target.value)
    }

    const keyDown = event  => {
        if (event.keyCode===13) 
            search()
    }

    const search = () => {
        props.setSearchCriteria({searchValue: searchValue})
        setSearchValue('')
    }

    return (
        <div className={props.styleName ? `search-bar ${props.styleName}` : 'search-bar'} onKeyDown={keyDown} >
            <input className='search-bar' type='text' placeholder='Search FairHub' value={searchValue}
                onChange={updateSearch}/>
            <div className='search-button' onClick={search}>
                <img className='search-button' src={searchIcon} alt='search'></img>
            </div>
        </div>
    )

}

export default SearchBar