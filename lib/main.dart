import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _selectionController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  void initState() {
    _unameController.addListener(() {
      print(_unameController.text);
    });
    focusNode1.addListener(() {
      print(focusNode1.hasFocus);
    });
    _selectionController.text = "Hello World!";
    _selectionController.selection = TextSelection(
      baseOffset: 3,
      extentOffset: _selectionController.text.length,
    );
  }

  @override
  void dispose() {
    _unameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //基本的登录界面
              TextField(
                autofocus: true,
                controller: _unameController,
                onChanged: (v) {
                  print("onChanged:$v");
                  setState(() {});
                },
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person)),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              TextField(
                controller: _selectionController,
                decoration: InputDecoration(
                    labelText: "Selection Controll",
                    hintText: "控制选择",
                    prefixIcon: Icon(Icons.local_activity)),
              ),
              Text('This is your name:${_unameController.text}'),
              TextField(
                autofocus: true,
                focusNode: focusNode1, //关联focusNode1
                decoration: InputDecoration(labelText: "input1"),
              ),
              TextField(
                focusNode: focusNode2, //关联focusNode2
                decoration: InputDecoration(labelText: "input2"),
              ),
              Builder(
                builder: (ctx) {
                  return Column(
                    children: <Widget>[
                      ElevatedButton(
                        child: Text("移动焦点"),
                        onPressed: () {
                          //将焦点从第一个TextField移到第二个TextField
                          // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                          // 这是第二种写法
                          if (null == focusScopeNode) {
                            focusScopeNode = FocusScope.of(context);
                          }
                          focusScopeNode!.requestFocus(focusNode2);
                        },
                      ),
                      ElevatedButton(
                        child: Text("隐藏键盘"),
                        onPressed: () {
                          // 当所有编辑框都失去焦点时键盘就会收起
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                      ),
                    ],
                  );
                },
              ),
              TextField(
                decoration: InputDecoration(
                  //自定义输入框样式
                  labelText: "请输入用户名",
                  prefixIcon: Icon(Icons.person),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                    hintColor: Colors.grey[200], //定义下划线颜色
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: 14.0) //定义提示文本样式
                        )),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名或邮箱",
                          prefixIcon: Icon(Icons.person)),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "密码",
                          hintText: "您的登录密码",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13.0)),
                      obscureText: true,
                    ),
                    Container(
                      //通过container来消除下划线
                      child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "电子邮件地址",
                              prefixIcon: Icon(Icons.email),
                              border: InputBorder.none //隐藏下划线
                              )),
                      decoration: BoxDecoration(
                          // 下滑线浅灰色，宽度1像素
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromRGBO(238, 238, 238, 1),
                                  width: 1.0))),
                    ),
                    //表单
                    Form(
                      key: _formKey, //设置globalKey，用于后面获取FormState
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autofocus: true,
                            controller: _unameController,
                            decoration: InputDecoration(
                              labelText: "用户名",
                              hintText: "用户名或邮箱",
                              icon: Icon(Icons.person),
                            ),
                            // 校验用户名
                            validator: (v) {
                              return v!.trim().isNotEmpty ? null : "用户名不能为空";
                            },
                          ),
                          TextFormField(
                            controller: _pwdController,
                            decoration: InputDecoration(
                              labelText: "密码",
                              hintText: "您的登录密码",
                              icon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            //校验密码
                            validator: (v) {
                              return v!.trim().length > 5 ? null : "密码不能少于6位";
                            },
                          ),
                          // 登录按钮
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text("登录"),
                                    ),
                                    onPressed: () {
                                      // 通过_formKey.currentState 获取FormState后，
                                      // 调用validate()方法校验用户名密码是否合法，校验
                                      // 通过后再提交数据。
                                      if ((_formKey.currentState as FormState)
                                          .validate()) {
                                        //验证通过提交数据
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
