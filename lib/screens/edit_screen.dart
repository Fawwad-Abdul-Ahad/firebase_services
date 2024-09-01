import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  File? _image;
  final picker = ImagePicker();
  bool loading = false;

  // Firebase storage and database references
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  // Controllers for name and price
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // Function to pick an image from the gallery
  Future getImageFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No image selected");
      }
    });
  }

  // add image function
  Future<void> addImage() async {
    setState(() {
      loading = true;
    });
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/productImage/' + DateTime.now().millisecond.toString());
    firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
    Future.value(uploadTask).then((value) async {
      var newURL = await ref.getDownloadURL();

      databaseRef
          .child('1')
          .set({'id': '1212', 'title': newURL.toString()}).then((value) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('image added succesfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
    });
  }

  // Function to upload data to Firebase
  Future<void> addProduct() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      // Create a reference to the location where the image will be stored
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('/productImage/' +
              DateTime.now().millisecondsSinceEpoch.toString());

      // Start the upload task
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

      // Await the completion of the upload task
      await uploadTask;

      // Get the download URL of the uploaded image
      var newURL = await ref.getDownloadURL();

      // Create a unique ID for the new product entry
      String id = DateTime.now().microsecondsSinceEpoch.toString();

      // Adding product details to Firebase
      await databaseRef.child(id).set({
        "name": nameController.text.toString(),
        "price": priceController.text.toString(),
        "imageURL": newURL.toString(),
        "id": id,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add data: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Edit Products"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Image section
              Text(
                "Add Image",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 234, 234),
                  borderRadius: BorderRadius.circular(28),
                ),
                width: 200,
                height: 200,
                child: InkWell(
                  onTap: getImageFromGallery,
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Icon(
                          Icons.image,
                          size: 200,
                        ),
                ),
              ),
              SizedBox(height: 22),

              // Add Name section
              Text(
                "Add Name",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Add Product Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 22),

              // Add Price section
              Text(
                "Add Price",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Add Product Price",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 28),

              // Add Product button with loading state
              loading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: addProduct,
                      child: Text("Add Product"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
