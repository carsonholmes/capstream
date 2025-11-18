var config = {};
config.server = {};
config.storage = [];

config.server.port = 7002;
config.server.appName = 'factory';

config.server.rootUrl = "http://localhost"
//config.server.rootUrl = "http://74.117.56.34"

config.server.url = "http://localhost:" + config.server.port;

config.storage['Golcher375'] = {path: 'c:\\dev\\nerm\\server\\public\\assets\\entity-images\\'}
config.storage['LAPTOP-ID9JH3OA'] = {path: 'c:\\dev\\nerm\\server\\public\\assets\\entity-images\\'}
config.storage['WIN-5LL8KSFAF97'] = {path: 'c:\\prod\\adenrel\\server\\public\\assets\\entity-images\\'}
config.storage['CATLAIN'] = {path: 'c:\\users\\decke\\source\\repos\\nerm\\server\\public\\assets\\entity-images\\'}

config.apikey = ''

config.githubPAT = ''
config.githubUserName = 'incrementum-softwarefactory'

config.db = []

config.db['golcher375'] = {
    user: 'root',
    password: 'clover4ME!',
    port: 3306,
    host: 'localhost',
    database: config.server.appName,
    timezone: 'UTC',
    multipleStatements: true
    //options: {
    //    encrypt: false // Use this if you're on Windows Azure 
    //}
}

config.db['CATLAIN'] = {
    user: 'root',
    password: 'Flashlight!45',
    port: 3306,
    host: 'localhost',
    database: config.server.appName,
    timezone: 'UTC',
    multipleStatements: true
    //options: {
    //    encrypt: false // Use this if you're on Windows Azure 
    //}
}

config.db['WIN-5LL8KSFAF97'] = {
    user: 'root',
    password: 'clover4ME!',
    port: 3306,
    host: 'localhost',
    database: config.server.appName,
    timezone: 'UTC',
    multipleStatements: true
    //options: {
    //    encrypt: false // Use this if you're on Windows Azure 
    //}
}

config.db['LAPTOP-ID9JH3OA'] = {
    user: 'root',
    password: 'hsinchu714Sql',
    port: 3306,
    host: 'localhost',
    database: config.server.appName,
    timezone: 'UTC',
    multipleStatements: true
    //options: {
    //    encrypt: false // Use this if you're on Windows Azure 
    //}
}

/* config.smtp = {
    port: 25,
    user: 'mbravo@coastasset.com',
    password: '',
    from: '"Danny Meyer Music ??" <mbravo@coastasset.com>',
    websiteName: 'Danny Meyer Music'
} */

config.smtp = {
    host: 'smtp.office365.com',
    port: 587,
    secure: false,
    user: 'contact@softwarefactory.ai',
    password: 'FourthM123',
    from: 'Incrementum Alpha <contact@softwarefactory.ai>',
    websiteName: 'incrementum.SoftwareFactory.ai'
}

export default config;