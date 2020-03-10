import * as functions from 'firebase-functions';
const sql = require('mssql');

export const sqlCloud = functions.https.onCall(async(data, context) => {
    var sqlConfig = {
        user: 'sa',
        password: '$m@rtHR7',
        server: '156.38.151.52',
        database: 'TimSHR',
        options: {
            instanceName: 'SQL2014',
            encrypt: true
       }
    };

    return new Promise((resolve, reject) => {
        console.log("sql connecting......")
        sql.connect(sqlConfig).then((d: any) => {
            let requestObj = new sql.Request();
            requestObj.query("select * from Users").then((e: any) => {
                console.log(e)
                resolve(e)
            }).catch((error: any) => {
                console.log(error)
                reject(error)
            });
        }).catch((error: any) => {
            console.log(error)
            reject(error)
        })
    })
});



export const plainCloud = functions.https.onCall(async(data, context) => {
    console.log('plain called');
    return null;
})




export const sqlCloudSS = functions.https.onCall(async(data, context) => {
    var sqlConfig = {
        user: 'SmartHR_Admin',
        password: 'fTsC=D*!',
        server: '160.119.141.249',
        database: 'SmartHR_Demo',
        options: {
            instanceName: 'SQL2017',
            encrypt: true
       }
    };

    return new Promise((resolve, reject) => {
        console.log("sql connecting......")
        sql.connect(sqlConfig).then((d: any) => {
            console.log('connected')
            let requestObj = new sql.Request();
            requestObj.query(data.SQLQuery).then((e: any) => {
                console.log('query')
                console.log(e)
                resolve(e)
            }).catch((error: any) => {
                console.log(error)
                reject(error)
            });
        }).catch((error: any) => {
            console.log(error)
            reject(error)
        })
    })
});