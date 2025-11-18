import dalEntity from '../DAL/dalEntity.js';
import dalEntityRelate from '../DAL/dalEntityRelate.js';

const ENTITY_USER = 1
const ENTITY_PERSON = 2
const ENTITY_GROUP = 8

export default {

    search: function(data, callback ) {
        dalEntity.selectEntityBySearch(data, (errEntity, resultEntity) => {
            if (!errEntity && resultEntity && resultEntity[0]) {
                callback(false, resultEntity[0])
            }
            else callback(false, {error: errEntity})
        })
    },

    view: function(data, callback ) {
        dalEntity.selectEntity(data, (errEntity, resultEntity) => {
            if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0]) {
                switch (resultEntity[0][0].entityType) {
                    // case ENTITY_POST: dalPost.selectPost( data, (errPost, resultPost) => {
                    //     if (!errPost && resultPost && resultPost[0] && resultPost[0][0]) {
                    //         var result = jsonFunctions.merge(resultEntity[0][0], resultPost[0][0])
                    //         callback(false, result)
                    //     }
                    //     else callback(false, {error: errPost})
                    // })
                    // break
                    // case ENTITY_ITEM: dalItem.selectItem( data, (errItem, resultItem) => {
                    //     if (!errItem && resultItem && resultItem[0] && resultItem[0][0]) {
                    //         var result = jsonFunctions.merge(resultEntity[0][0], resultItem[0][0])
                    //         dalOffer.selectOfferForEntity( {idEntity: data.idEntity}, (errOffer, resultOffer) => {
                    //             if (!errOffer && resultOffer && resultOffer[0] && resultOffer[0][0]) {
                    //                 result.offer = {...resultOffer[0][0]}
                    //             }
                    //             else result.offer = {price: 0}
                    //             callback(false, result)
                    //         })
                    //     }
                    //     else callback(false, {error: errItem})
                    // })
                    // break
                    // case ENTITY_SERVICE: dalService.selectService( data, (errService, resultService) => {
                    //     if (!errService && resultService && resultService[0] && resultService[0][0]) {
                    //         var result = jsonFunctions.merge(resultEntity[0][0], resultService[0][0])
                    //         dalOffer.selectOfferForEntity( {idEntity: data.idEntity}, (errOffer, resultOffer) => {
                    //             if (!errOffer && resultOffer && resultOffer[0] && resultOffer[0][0]) {
                    //                 result.offer = {...resultOffer[0][0]}
                    //             }
                    //             else result.offer = {price: 0}
                    //             callback(false, result)
                    //         })
                    //     }
                    //     else callback(false, {error: errService})
                    // })
                    // break
                    default: callback(false, resultEntity[0][0])
                }
            }
            else callback(false, {error: errEntity})
        })
    },

    loadContent: function(data, callback ) {
        dalEntityRelate.selectEntityRelate({idEntity: data.idEntity, relateType: 2}, (errER, resultER) => {  // 2 is for linked content
            if (!errER && resultER && resultER[0]) {
                callback(false, resultER[0])
            }
            else callback(false, {error: errER})
        })
    },

    loadOwner: function(data, callback ) {
        dalEntityRelate.selectEntityRelate({idEntity: data.idEntity, relateType: 1}, (errER, resultER) => {  // 2 is for linked content
            if (!errER && resultER && resultER[0]) {
                callback(false, resultER[0])
            }
            else callback(false, {error: errER})
        })
    },

    // loadCategories: function(data, callback ) {
    //     dalEntityCategory.selectEntityCategory({idEntity: data.idEntity}, (errEC, resultEC) => { 
    //         if (!errEC && resultEC && resultEC[0]) {
    //             callback(false, resultEC[0])
    //         }
    //         else callback(false, {error: errEC})
    //     })
    // },

    // loadOffer: function(data, callback ) {
    //     dalOffer.selectOfferForEntity({idEntity: data.idEntity}, (errOffer, resultOffer) => {  
    //         if (!errOffer && resultOffer && resultOffer[0]) {
    //             callback(false, resultOffer[0][0])
    //         }
    //         else callback(false, {error: errOffer})
    //     })
    // },

    // loadArea: function(data, callback ) {
    //     dalEntityArea.selectEntityArea({idEntity: data.idEntity}, (errArea, resultArea) => {  
    //         if (!errArea && resultArea && resultArea[0]) {
    //             callback(false, resultArea[0][0])
    //         }
    //         else callback(false, {error: errArea})
    //     })
    // },

    selectEntityByOwner: function (data, callback) {
        dalEntity.selectEntityByOwner( data, (errEntity, resultEntity) => {
            if (!errEntity && resultEntity && resultEntity[0])
                callback( false, resultEntity[0])
            else
                callback( false, {error: errEntity})
        })  
    },

    insertEntity: function(data, callback ) {
        dalEntity.insertEntity(data, (errEntity, resultEntity) => {
            if (!errEntity && resultEntity && resultEntity[0] && resultEntity[0][0]) {
                dalEntityRelate.insertEntityRelate({idEntity: resultEntity[0][0].idEntity, idRelated: data.idUser, relateType: 1}, (errER, resultER) => { // 1 is owns (see Master Type)
                    if (!errER) {
                        // for (let i=0; i<data.media.length; i++) {
                        //     var mediaData = {...data.media[i]}
                        //     mediaData.idEntity = resultEntity[0][0].idEntity
                        //     mediaData.idUser = data.idUser
                        //     bplMedia.insertMedia(mediaData, (errMedia, resultMedia) => {
                        //         if (!errMedia) {
                        //             // successfully saved Media with entity
                        //         }
                        //         else console.log('Error saving media for entity.')
                        //     })
                        // }
                        // for (let i=0; i<data.content.length; i++) {
                        //     var contentData = {}
                        //     contentData.idEntity = resultEntity[0][0].idEntity
                        //     contentData.idRelated = data.content[i].idEntity
                        //     contentData.relateType = 2 // 2 is the code for linked-to (see MasterType)
                        //     dalEntityRelate.insertEntityRelate(contentData, (errER2, resultER2) => {
                        //         if (!errER2) {
                        //             // successfully saved linked content
                        //         }
                        //         else console.log('Error saving linked content for entity.')
                        //     })
                        // }
                        // for (let i=0; i<data.category.length; i++) {
                        //     var categoryData = {}
                        //     categoryData.idEntity = resultEntity[0][0].idEntity
                        //     categoryData.idCategory = data.category[i].idCategory
                        //     dalEntityCategory.insertEntityCategory(categoryData, (errEC, resultEC) => {
                        //         if (!errEC) {
                        //             // successfully saved linked category
                        //         }
                        //         else {
                        //             console.table(errEC)
                        //             console.log('Error saving category for entity.')
                        //         }
                        //     })
                        // }
                        data.idEntity = resultEntity[0][0].idEntity
                        // switch (data.entityType) {
                        //     case ENTITY_POST: dalPost.insertPost( data, (errPost, resultPost) => {
                        //         if (!errPost) callback( false, resultEntity[0][0])
                        //         else callback(false, {error: errPost})
                        //     })
                        //     break
                        //     case ENTITY_ITEM: dalItem.insertItem( data, (errItem, resultItem) => {
                        //         if (!errItem) {
                        //             dalOffer.insertOffer( {...data.offer, idEntity: data.idEntity}, (errOffer, resultOffer) => {
                        //                 if (!errOffer && resultOffer && resultOffer[0] && resultOffer[0][0]) {
                        //                     resultEntity[0][0].offer = data.offer
                        //                     resultEntity[0][0].offer.idOffer = resultOffer[0][0].idOffer
                        //                     callback( false, resultEntity[0][0])
                        //                 }
                        //                 else callback(false, {error: errOffer})
                        //             })
                        //         }
                        //         else callback(false, {error: errItem})
                        //     })
                        //     break
                        //     case ENTITY_SERVICE: dalService.insertService( data, (errService, resultService) => {
                        //         if (!errService) {
                        //             dalOffer.insertOffer( {...data.offer, idEntity: data.idEntity}, (errOffer, resultOffer) => {
                        //                 if (!errOffer && resultOffer && resultOffer[0] && resultOffer[0][0]) {
                        //                     resultEntity[0][0].offer = data.offer
                        //                     resultEntity[0][0].offer.idOffer = resultOffer[0][0].idOffer
                        //                     dalEntityArea.insertEntityArea({...data.offer.area, idEntity: data.idEntity}, (errArea, resultArea) => {
                        //                         if (!errArea) {
                        //                             callback( false, resultEntity[0][0])
                        //                         }
                        //                         else callback(false, {error: errArea})
                        //                     })                                        
                        //                 }
                        //                 else callback(false, {error: errOffer})
                        //             })
                        //         }
                        //         else callback(false, {error: errService})
                        //     })
                        //     break
                        //}
                    }
                    else callback(false, {error: errER})
                })  
                
            }
            else callback( false, {error: errEntity})
        })
    },

    updateEntity: function(data, callback ) {
        dalEntity.updateEntity(data, (errEntity, resultEntity) => {
            // bplMedia.updateMediaArray(data, (errMedia, resultMedia) => {
            //         if (!errMedia) {
            //             // successfully saved Media with entity
            //         }
            //         else console.log('Error saving media for entity.')
            // })
            // for (let i=0; i<data.content.length; i++) {
            //     var contentData = {}
            //     contentData.idEntity = data.idEntity
            //     contentData.idRelated = data.content[i].idEntity
            //     contentData.relateType = 2 // 2 is the code for linked-to (see MasterType)
            //     if (data.content[i].new) {
            //         dalEntityRelate.insertEntityRelate(contentData, (errER2, resultER2) => {
            //             if (!errER2) {
            //                 // successfully saved linked content
            //             }
            //             else console.log('Error saving linked content for entity.')
            //         })
            //     }
            //     else if (data.content[i].markedForDeletion) {
            //         dalEntityRelate.deleteEntityRelate(contentData, (errER2, resultER2) => {
            //             if (!errER2) {
            //                 // successfully saved linked content
            //             }
            //             else console.log('Error deleting linked content for entity.')
            //         })
            //     }
            // }
            // for (let i=0; i<data.category.length; i++) {
            //     var categoryData = {}
            //     categoryData.idEntity = data.idEntity
            //     categoryData.idCategory = data.category[i].idCategory
            //     if (data.category[i].new) {
            //         dalEntityCategory.insertEntityCategory(categoryData, (errEC, resultEC) => {
            //             if (!errEC) {
            //                 // successfully saved linked category
            //             }
            //             else {
            //                 console.table(errEC)
            //                 console.log('Error saving category for entity.')
            //             }
            //         })
            //     }
            //     else if (data.category[i].markedForDeletion) {
            //         dalEntityCategory.deleteEntityCategory(categoryData, (errEC, resultEC) => {
            //             if (!errEC) {
            //                 // successfully saved linked category
            //             }
            //             else console.log('Error deleting category for entity.')
            //         })
            //     }
            // }
            if (!errEntity)
                // switch (data.entityType) {
                //     case ENTITY_POST: dalPost.updatePost( data, (errPost, resultPost) => {
                //         if (!errPost) {
                             callback( false, resultEntity)
                //         }
                //         else callback(false, {error: errPost})
                //     })
                //     break
                //     case ENTITY_ITEM: dalItem.updateItem( data, (errItem, resultItem) => {
                //         if (!errItem)
                //             if (data.offer.idOffer) {
                //                 dalOffer.updateOffer( data.offer, (errOffer, resultOffer) => {
                //                     if (!errOffer) callback( false, resultEntity)
                //                     else callback( false, {error: errOffer})
                //                 })}
                //             else {
                //                 var newData = {...data.offer, idEntity: data.idEntity}
                //                 newData.active = 1
                //                 dalOffer.insertOffer( newData, (errOffer, resultOffer) => {
                //                     if (!errOffer && resultOffer && resultOffer[0] && resultOffer[0][0]) {
                //                             resultEntity[0][0].offer = data.offer
                //                             resultEntity[0][0].offer.idOffer = resultOffer[0][0].idOffer
                //                             dalEntityArea.insertEntityArea({...data.offer.area, idEntity: data.idEntity}, (errArea, resultArea) => {
                //                                 if (!errArea && resultArea && resultArea[0] && resultArea[0][0]) {
                //                                     callback( false, resultEntity[0][0])
                //                                 }
                //                                 else callback(false, {error: errArea})
                //                             })                                        
                //                         }
                //                         else callback(false, {error: errOffer})
                //                 })
                //             }
                //         else callback(false, {error: errItem})
                //     })
                //     break
                //     case ENTITY_SERVICE: dalService.updateService( data, (errService, resultService) => {
                //         if (!errService) {
                //             if (data.offer.idOffer) {
                //                 dalOffer.updateOffer( {...data.offer, idEntity: data.idEntity}, (errOffer, resultOffer) => {
                //                     if (!errOffer)
                //                         dalEntityArea.updateEntityArea({...data.offer.area, idEntity: data.idEntity}, (errArea, resultArea) => {
                //                             if (!errArea) {
                //                                 callback( false, resultEntity)
                //                             }
                //                             else callback(false, {error: errArea})
                //                         })                  
                //                     else {
                //                         console.log('Error updating Offer')
                //                         callback( false, {error: errOffer})
                //                     }
                //                 })}
                //             else {
                //                 dalOffer.insertOffer( {...data.offer, idEntity: data.idEntity}, (errOffer, resultOffer) => {
                //                     if (!errOffer && resultOffer && resultOffer[0] && resultOffer[0][0]) {
                //                         resultEntity.offer = data.offer
                //                         resultEntity.offer.idOffer = resultOffer.idOffer
                //                         dalEntityArea.insertEntityArea({...data.offer.area, idEntity: data.idEntity}, (errArea, resultArea) => {
                //                             if (!errArea) {
                //                                 callback( false, resultEntity)
                //                             }
                //                             else callback(false, {error: errArea})
                //                         })                                        
                //                     }
                //                     else callback(false, {error: errOffer})
                //                 })
                //             }
                //         }
                //         else callback(false, {error: errService})
                //     })
                // }
            else
                callback( false, errEntity)
        })
    },

    verifyRelate: function(data, callback ) {
        dalEntityRelate.verifyEntityRelate(data, (errEntity, resultEntity) => {
            if (!errEntity && resultEntity && resultEntity[0]) {
                callback(false, resultEntity[0])
            }
            else callback(false, {error: errEntity})
        })
    },

    deleteEntities: function(data, callback ) {
        //loop through entities in data to delete them 
        for (let i=0; i<data.length; i++)
            this.deleteEntity(data[i], (errEntity, resultEntity) => {
                if (i===data.length-1)
                    if (!errEntity && resultEntity)
                        callback( false, resultEntity)
                    else
                        callback( false, errEntity)
            })
    },

    deleteEntity: function(data, callback) {
        //delete any entity_relates
        dalEntityRelate.deleteEntityRelateAll(data, (errER, resultER)=>{
            if (errER) console.log('Error deleting EntityRelate data for entity: ' + data.idEntity)
        })
        //delete any media
        // bplMedia.deleteMediaAll(data, (errMedia, resultMedia)=>{
        //     if (errMedia) console.log('Error deleting media data for entity: ' + data.idEntity)
        // })
        //delete any entityAttributes - add later
        //delete any entityCategories - add later
        //delete auxillary entity data
        // switch (data.entityType) {
        //     case ENTITY_POST: dalPost.deletePost( data, (errPost, resultPost) => {
        //         if (!errPost) this.deleteEntityRecordOnly(data, callback)
        //         else {
        //             console.log('Error deleting post data for entity: ' + data.idEntity)
        //             callback( false, {error: errPost})
        //         }
        //     })
        //     break
        //     case ENTITY_ITEM: dalItem.deleteItem( data, (errItem, resultItem) => {
        //         if (!errItem) this.deleteEntityOffer(data, callback)
        //         else {
        //             console.log('Error deleting item data for entity: ' + data.idEntity)
        //             callback( false, {error: errItem})
        //         }
        //     })
        //     break
        //     case ENTITY_SERVICE: dalService.deleteService( data, (errService, resultService) => {
        //         if (!errService) this.deleteEntityOffer(data, callback)
        //         else {
        //             console.log('Error deleting service data for entity: ' + data.idEntity)
        //             callback( false, {error: errService})
        //         }
        //     })
        //     break
        // }
        
    },

    // deleteEntityOffer: function(data, callback) {
    //     if (!data.offer || !data.offer.offerId) dalOffer.selectOfferForEntity(data, (errOffer, resultOffer) => {
    //         if (!errOffer) {
    //             dalOffer.deleteOffer(resultOffer[0][0], (errOffer2, resultOffer2) => {
    //                 if (!errOffer2) this.deleteEntityRecordOnly(data, callback)
    //                 else { 
    //                     console.log('Error deleting offer data for entity after retrieving offer: ' + data.idEntity)
    //                     callback( false, {error: errOffer2})
    //                 }
    //             })
    //         }
    //         else callback( false, {error: errOffer})
    //     })
    //     else dalOffer.deleteOffer(data.offer, (errOffer, resultOffer) => {
    //         if (!errOffer) this.deleteEntityRecordOnly(data, callback)
    //         else { 
    //             console.log('Error deleting offer data for entity: ' + data.idEntity)
    //             callback( false, {error: errOffer})
    //         }
    //     })
    // },

    deleteEntityRecordOnly: function(data, callback) {
        //delete the entity
        dalEntity.deleteEntity(data, (errEntity, resultEntity) => {
            if (!errEntity && resultEntity)
                callback( false, resultEntity[0])
            else
                callback( false, errEntity)
        })
    }

};

