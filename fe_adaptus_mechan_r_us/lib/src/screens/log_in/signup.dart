import 'package:flutter/material.dart';

enum WidgetMarker{
  User,Garage
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text('Sign Up')
        ),
        body: userWidget(),
      ),
    );
  }
}

class userWidget extends StatefulWidget {
  @override
  _userWidgetState createState() => _userWidgetState();
}

class _userWidgetState extends State<userWidget> {
  final _formKey = GlobalKey<FormState>();
  WidgetMarker selectedWidgetMarker =WidgetMarker.User;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              color: Colors.deepOrange,
              onPressed: (){
                setState(() {
                  selectedWidgetMarker=WidgetMarker.User;
                });
              }, child:Text('User')
            ),
            FlatButton(
                onPressed: (){
                  setState(() {
                    selectedWidgetMarker=WidgetMarker.Garage;
                  });
                }, child:Text('Garage')
            ),
          ],
        ),
        Container(
          height: 450,
          color: Colors.white,
          child: getCustomContainer(),
        )
      ],
    );
  }
  Widget getCustomContainer(){
    switch (selectedWidgetMarker){
      case WidgetMarker.User:
        return getUserForm();
      case WidgetMarker.Garage:
        return getGarageForm();
    }
    return getUserForm();
  }
  Widget getUserForm(){
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          new TextFormField(
            style: new TextStyle(
                fontSize: 15.0,
                height: 0.5,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Enter Username",

                prefixIcon: Icon(Icons.person_add,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 15.0,
                height: 0.5,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Enter Password",
                prefixIcon: Icon(Icons.security,color: Colors.black,)
            ),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 15.0,
                height: 0.5,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Enter Name",
                prefixIcon: Icon(Icons.person,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 15.0,
                height: 0.5,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Enter Email",
                prefixIcon: Icon(Icons.email,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 15.0,
                height: 0.5,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Phonenumber",
                prefixIcon: Icon(Icons.phone_android,color:Colors.black,)
            ),
            keyboardType: TextInputType.number,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 15.0,
                height: 0.5,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "PaymentEmail",
                prefixIcon: Icon(Icons.email,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
  Widget getGarageForm(){
    return Form(
      key: _formKey,
      child:ListView(
        children: <Widget>[
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Garage Name",
                prefixIcon: Icon(Icons.business,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,

          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Garage Description",
                prefixIcon: Icon(Icons.text_fields,color: Colors.black,)
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Garage image path",
                prefixIcon: Icon(Icons.image,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Garage base price",
                prefixIcon: Icon(Icons.attach_money,color:Colors.black,)
            ),
            keyboardType: TextInputType.number,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "GaragePaymentEmail",
                prefixIcon: Icon(Icons.email,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
                labelText: "Garagae Address Line one",
                prefixIcon: Icon(Icons.home,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
              labelText: "Garagae Address Line two",
                prefixIcon: Icon(Icons.home,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
              labelText: "Garage County",
                prefixIcon: Icon(Icons.home,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,

          ),
          new TextFormField(
            style: new TextStyle(
                fontSize: 12.0,
                height: 0.1,
                color: Colors.black
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: new InputDecoration(
              labelText: "Garage postcode",
                prefixIcon: Icon(Icons.home,color:Colors.black,)
            ),
            keyboardType: TextInputType.text,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),

        ],
      ),
    );
  }

}
