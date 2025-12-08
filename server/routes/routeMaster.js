import index from './index.js';
import email from './email.js';
import user from './user.js';
//import media from './media.js';
import entity from './entity.js';
import group from './group.js'
import positions from './positions.js'
import updates from './updates.js'
import cashActivity from './cash-activity.js'
import attachments from './attachments.js'

const routeMaster = { "use" :  (app) => {
    app.use('/', index);
    app.use('/email', email);
    app.use('/user', user);
    //app.use('/media', media);
    app.use('/entity', entity);
    app.use('/group', group);
    app.use('/attachments', attachments);
    app.use('/positions', positions);
    app.use('/updates', updates);
    app.use('/cash-activity', cashActivity);
    }
}

export default routeMaster;