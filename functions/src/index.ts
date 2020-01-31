import * as functions from 'firebase-functions';
const sql = require('mssql');

export const connectANDPull = functions.https.onCall(async(data, context) => {
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

export const roundtriptest = functions.https.onCall(async(data, context) => {
    console.log('hello');
    console.log(10*10*10*10*10*10*10*440*5454654*4546);
    return null;
})