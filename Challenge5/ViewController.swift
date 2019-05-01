//
//  ViewController.swift
//  Challenge5
//
//  Created by Alexis Orellano on 4/23/19.
//  Copyright © 2019 Alexis Orellano. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationSetup()
    }
    
    func navigationSetup(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Photos"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takeAPhoto))
    }
    
    @objc func takeAPhoto(){
        print("Youre going to take a photo")
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
    
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }

        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Enter caption for photo", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let enterAction = UIAlertAction(title: "Enter", style: .default) {[weak ac, weak self] action in
            guard let photoCaption = ac?.textFields?[0].text else { return }
            
            let photo = Photo(image: imageName, caption: photoCaption)
            self?.photos.append(photo)
            self?.tableView.reloadData()
            
            print(photo.caption)
            
            print(self?.photos[0].caption ?? "No caption")
            
        }
        ac.addAction(enterAction)
        present(ac, animated: true)
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        let photo = photos[indexPath.row]
        cell.textLabel?.text = photo.caption
        //print(photo.caption)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let photo = photos[indexPath.row]
            let path = getDocumentsDirectory().appendingPathComponent(photo.image)
            let image = UIImage(contentsOfFile: path.path)
            
            detailVC.selectedImage = image
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }
}
