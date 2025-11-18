import icons from './icons.js'
import config from '../config/appConfig'
import { ENTITY_EVENT, ENTITY_GROUP, ENTITY_ITEM, ENTITY_PLACE, ENTITY_POST, ENTITY_SERVICE } from '../cdos/EntityCDO.js'

const mediaPath = (i, data, idEntity, entityType) => {
    var path
    if (data[i]) {
        if (data[i].new) path = `${config.server.url}:${config.server.webServicesPort}/assets/entity-images/uploads/${data[i].fileName}`
        else path = `${config.server.url}:${config.server.webServicesPort}/assets/entity-images/${idEntity}/${data[i].fileName}`
        return path
    }
    else {
        return emptySrc(entityType)
    }
}

export const emptySrc = (entityType) => {
    switch (entityType) {
        case ENTITY_EVENT: return icons.emptyEvent
        case ENTITY_GROUP: return icons.emptyGroup
        case ENTITY_ITEM: return icons.emptyItem
        case ENTITY_PLACE: return icons.emptyPlace
        case ENTITY_POST: return icons.emptyPost
        case ENTITY_SERVICE: return icons.emptyService
        default: return icons.emptyAvatar
    }
}

export default mediaPath