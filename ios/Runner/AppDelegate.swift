import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        // Definimos el canal para traer los todos los post
        let getAllPostsChannel = FlutterMethodChannel(name: "methods/get-all-posts", binaryMessenger: controller.binaryMessenger);
        
        // definimos el canal para traer los comentarios por post
        let getCommentsChannel = FlutterMethodChannel(name: "methods/get-comments-by-post-id", binaryMessenger: controller.binaryMessenger);
        
        
        getCommentsChannel.setMethodCallHandler { [weak self] (call, result) in
            // Si el método no es correcto, arroja un FlutterMethodNotImplemented Exception
            guard call.method == "getCommentsByPostId" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            // Obtenemos los argumentos de flutter y llamamos a la funcion
            if let args = call.arguments as? [String: Any], let id = args["postId"] as? Int {
                self?.getCommentsByPostId(result: { (flutterResult) in
                    result(flutterResult)
                }, postId:id)
            } else {
                result(FlutterError(code: "NO_DATA", message: "No postID provided", details: nil))
            }
    }
        
        
        // Definimos el handler del método getAllPosts
        getAllPostsChannel.setMethodCallHandler { [weak self] (call, result) in
            // Si el método no es correcto, arroja un FlutterMethodNotImplemented Exception
            guard call.method == "getAllPosts" else {
                result(FlutterMethodNotImplemented)
                return
            }
            // Llamamos a funcion getAllPosts de esta misma clase
            //
            // obtenemos el resultado a traves del callback y lo retornamos en el methodChannel
            self?.getAllPosts(result: { (flutterResult) in
                result(flutterResult)
            })
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func getAllPosts(result: @escaping FlutterResult) {
        
        // Especificamos la URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!;
        // Preparamos el REQUEST
        var request = URLRequest(url: url);
        
        // Definimos headers y tipo de request
        request.httpMethod = "GET";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print(error);
                return;
            }
            
            // Si no hay datos, retornamos un FlutterError y salimos de la función
            guard let data = data else {
                print("No hay datos")
                result(FlutterError(code: "NO_DATA", message: "No hay datos", details: nil))
                return
            }
            
            do {
                // Parseamos la respuesta a JSON designando Post como objetoa parsear
                let decoder = JSONDecoder();
                let posts = try decoder.decode([Post].self, from: data)
                
                // Creamos un Encoder para serializar los posts
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(posts);
                
                // Lo convertimos a string
                let jsonString = String(data: jsonData, encoding: .utf8)
                
                //retornamos la respuesta
                if let jsonString = jsonString {
                    result(jsonString)
                } else {
                    result(FlutterError(code: "JSON_CONVERSION_ERROR", message: "Error al convertir JSON", details: nil))
                }
            } catch _ {
                return
            }
            
        }
        
        // Hace el fetch de la petición
        task.resume();
    }
    
    private func getCommentsByPostId(result: @escaping FlutterResult, postId: Int){
        // Especificamos la URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)")!;
        
        // Preparamos el REQUEST
        var request = URLRequest(url: url);
        
        // Definimos headers y tipo de request
        request.httpMethod = "GET";
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print(error);
                return;
            }
            
            // Si no hay datos, retornamos un FlutterError y salimos de la función
            guard let data = data else {
                print("No hay datos")
                result(FlutterError(code: "NO_DATA", message: "No hay datos", details: nil))
                return
            }
            
            do {
                // Parseamos la respuesta a JSON designando Post como objetoa parsear
                let decoder = JSONDecoder();
                let posts = try decoder.decode([Comment].self, from: data)
                
                // Creamos un Encoder para serializar los posts
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(posts);
                
                // Lo convertimos a string
                let jsonString = String(data: jsonData, encoding: .utf8)
                
                //retornamos la respuesta
                if let jsonString = jsonString {
                    result(jsonString)
                } else {
                    result(FlutterError(code: "JSON_CONVERSION_ERROR", message: "Error al convertir JSON", details: nil))
                }
            } catch _ {
                return
            }
            
        }
        
        // Hace el fetch de la petición
        task.resume();
    }
    
    
}
        
struct Post: Codable {
    let userId : Int
    let id: Int
    let title: String
    let body: String
}

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
