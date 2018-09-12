//
//  NetworkTool.swift
//  swift_Community
//
//  Created by MM on 2018/9/11.
//  Copyright © 2018年 MM. All rights reserved.
//

import Foundation
import DaisyNet
import Alamofire
import SwiftyJSON
import HandyJSON

class responseModel: HandyJSON {
    var result:NetworkRetcode!
    var info: String!
    var data: NSDictionary!
    
    required init() {}
}

public enum NetworkRetcode:Int,HandyJSONEnum {
    case NetworkRetcodeSuccess = 1
    case NetworkRetcodeError = 0
}
public typealias NetworkTool_requestSucessHandle = (_ response: NSDictionary, _ retcode:NetworkRetcode,_ message:String) -> Void
public typealias NetworkTool_requestFailedHandle = (_ error: Error) -> Void
public typealias NetworkTool_progressHandle = (_ progress: Double) -> Void

public class NetworkTool:NSObject {
    class func request(
        _ url: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil,
        dynamicParams: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cache: Bool = false,
        success : @escaping NetworkTool_requestSucessHandle,
        failure: @escaping NetworkTool_requestFailedHandle)
    {
        let jk = JKEncrypt.init()
        let str = convertDictionaryToString(dict: params! as [String : AnyObject])
        print(str)
        let DataDic:[String:String] = ["data":jk.doStr(str)]
        return DaisyNet.request(url, method: method, params: DataDic, dynamicParams: dynamicParams, encoding: encoding, headers: headers).cache(cache).responseCacheAndString(completion: { value in
            switch value.result {
            case .success(let string):
                let data:NSData = jk.doDecEncryptStr(string).data(using: .utf8)! as NSData
                let s:String = String.init(data: data as Data, encoding: .utf8)!
                print("response:\(s)")
                let response = responseModel.deserialize(from: s)
                success((response?.data)!,(response?.result)!,(response?.info)!)
                if value.isCacheData {
                    
                } else {
                    
                }
                
            case .failure(let error):
                failure(error)
                print(error)
            }
        })
    }
    /// 上传一组图片
    ///
    /// - Parameters:
    ///   - urlString: 地址URL
    ///   - params: 参数
    ///   - name: 服务端定义接收数据的字段名称
    ///   - datas: 图片的Data数组
    ///   - method: 请求方法，默认post
    ///   - success: 成功的回调
    ///   - failure: 失败的回调
    ///   - progressHandle: 进度回调
    class func upLoadImages(
        to urlString: String,
        params:[String:String],
        name: String,
        datas: [Data],
        method: HTTPMethod = .get,
        success: @escaping NetworkTool_requestSucessHandle,
        failure: @escaping NetworkTool_requestFailedHandle,
        progressHandle: NetworkTool_progressHandle? = nil) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type": "multipart/form-data"
        ]
        Alamofire.upload(multipartFormData: { (mutipartData) in
            let jk = JKEncrypt.init()
            let str = convertDictionaryToString(dict: params as [String : AnyObject])
            print(str)
            let DataDic:[String:String] = ["data":jk.doStr(str)]
            for (key, value) in DataDic {
                if let data = value.data(using: String.Encoding.utf8) {
                    mutipartData.append(data, withName: key)
                }
            }
            for i in 0..<datas.count {
                mutipartData.append(datas[i], withName: name, fileName: "uploadImage\(i)", mimeType: "image/jpg"/*file*/)
            }
        },to: urlString,
          method: method,
          headers: headers,
          encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let jk = JKEncrypt.init()
                            let jmstr = String.init(data: value as! Data, encoding: .utf8)
                            let data:NSData = jk.doDecEncryptStr(jmstr).data(using: .utf8)! as NSData
                            let s:String = String.init(data: data as Data, encoding: .utf8)!
                            print("response:\(s)")
                            let response = responseModel.deserialize(from: s)
                            success((response?.data)!,(response?.result)!,(response?.info)!)
                        }
                    case .failure(let error):
                        failure(error)
                    }
                    }.uploadProgress(closure: { (progress) in
                        if let progressHandle = progressHandle {
                            progressHandle(progress.fractionCompleted)
                        }
                    })
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
    
}
func convertDictionaryToString(dict:[String:AnyObject]) -> String {
    var result:String = ""
    do {
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
        
        if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
            result = JSONString
        }
        
    } catch {
        result = ""
    }
    return result
}

