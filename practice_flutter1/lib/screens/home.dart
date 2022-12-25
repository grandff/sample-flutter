import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // button 1
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    // button 2
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sweet Home",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grocery",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline2!.color,
                        fontSize:
                            Theme.of(context).textTheme.headline2!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.headline2!.fontWeight,
                      ),
                    ),
                    Text(
                      "Shopping",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline2!.color,
                        fontSize:
                            Theme.of(context).textTheme.headline2!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.headline2!.fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time Left',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontWeight,
                            ),
                          ),
                          Text(
                            '2h 45m',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Dec 12, 2022',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontWeight,
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Assignee',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .fontWeight,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.translate(
                                offset: const Offset(20, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(5, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black,
                                  ),
                                  child: const Icon(
                                    Icons.person_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Additional Description',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize:
                            Theme.of(context).textTheme.headline1!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.headline1!.fontWeight,
                      ),
                    ),
                    Text(
                      'We have to buy some fresh bread, fruit, and vegetables Supply of water is running out.',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.bodyText1!.fontWeight,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Created',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline1!.color,
                        fontSize:
                            Theme.of(context).textTheme.headline1!.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.headline1!.fontWeight,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Dec 10, by Matt',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize:
                                Theme.of(context).textTheme.bodyText1!.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .fontWeight,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.person_add,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Set As Done',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
