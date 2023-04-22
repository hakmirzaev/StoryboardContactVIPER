
import Foundation

protocol HttpManagerProtocol {
    func apiContactList(completion: @escaping ([Contact]) -> Void)
    func apiContactDelete(contact: Contact, completion: @escaping (Bool) -> Void)
    func apiContactCreate(contact: Contact, completion: @escaping (Bool) -> Void)
    func apiContactEdit(contact: Contact, completion: @escaping (Bool) -> Void)
}

class HttpManager: HttpManagerProtocol {
    func apiContactList(completion: @escaping ([Contact]) -> Void) {
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                completion(contacts)
            case let .failure(error):
                print(error)
                completion([Contact]())
            }
        })
    }
    
    func apiContactDelete(contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
    
    func apiContactCreate(contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact), handler: { response in
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
    
    func apiContactEdit(contact: Contact, completion: @escaping (Bool) -> Void) {
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + contact.id!, params: AFHttp.paramsContactUpdate(contact: contact), handler: { response in
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
    
    
}
