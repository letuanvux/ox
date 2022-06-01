class Wanted {
  String name;
  String imgUrl;
  String city;
  String district;
  int priceInDollars;

  Wanted({
    required this.name,
    required this.imgUrl,
    required this.city,
    required this.district,
    required this.priceInDollars,
  });

  static List<Wanted> getFeaturedItems() {
    return allItems.take(10).toList()..shuffle();
  }

  static List<Wanted> getTrendingItems() {
    return allItems.take(12).toList()..shuffle();
  }

  static List<Wanted> getDiscountItems() {
    return allItems.take(14).toList()..shuffle();
  }

  static List<Wanted> allItems = [
    Wanted(
      name: "Chó Chihuahua",
      imgUrl: "assets/images/animal/dog1.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Husky",
      imgUrl: "assets/images/animal/dog2.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Shiba Inu",
      imgUrl: "assets/images/animal/dog3.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Golden Retriever",
      imgUrl: "assets/images/animal/dog4.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Becgie",
      imgUrl: "assets/images/animal/dog5.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Corgi",
      imgUrl: "assets/images/animal/dog6.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Mông Cộc",
      imgUrl: "assets/images/animal/dog7.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Alaska",
      imgUrl: "assets/images/animal/dog4.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Poodle",
      imgUrl: "assets/images/animal/dog5.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Golden",
      imgUrl: "assets/images/animal/dog2.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
    Wanted(
      name: "Chó Corgi",
      imgUrl: "assets/images/animal/dog6.jpg",
      city: 'Ha Noi',
      district: 'Bac Tu Liem',
      priceInDollars: 20,
    ),
  ];

}


class EventMeeting {
  String name;
  String imgUrl;

  EventMeeting({
    required this.name,
    required this.imgUrl,
  });

  static List<EventMeeting> getFeaturedItems() {
    return allItems.take(5).toList()..shuffle();
  }

  static List<EventMeeting> getTrendingItems() {
    return allItems.take(7).toList()..shuffle();
  }

  static List<EventMeeting> getDiscountItems() {
    return allItems.take(9).toList()..shuffle();
  }

  static List<EventMeeting> allItems = [
    EventMeeting(
      name: "Mr&Ms Thú Cưng Imou 2021", 
      imgUrl: "assets/images/events/event1.jpg",    
    ),
    EventMeeting(
      name: "Pet Care Show 2020", 
      imgUrl: "assets/images/events/event2.jpg",    
    ),
    EventMeeting(
      name: "Westminster Kennel Club Dog Show 2021", 
      imgUrl: "assets/images/events/event3.jpg",    
    ),
    EventMeeting(
      name: "Lễ hội cún cưng Sài Gòn 2019", 
      imgUrl: "assets/images/events/event4.jpg",    
    ),
    EventMeeting(
      name: "Cuộc thi \"Nét đẹp thú cưng\"", 
      imgUrl: "assets/images/events/event5.jpg",    
    ),
    EventMeeting(
      name: "Hachiko Festival: Hội Chợ Vì Thú Cưng", 
      imgUrl: "assets/images/events/event6.jpg",    
    ),
    EventMeeting(
      name: "Pet Care Show 2020", 
      imgUrl: "assets/images/events/event7.jpg",    
    ),
    EventMeeting(
      name: "Westminster Kennel Club Dog Show 2021", 
      imgUrl: "assets/images/events/event8.jpg",    
    ),
    EventMeeting(
      name: "Lễ hội cún cưng Sài Gòn 2019", 
      imgUrl: "assets/images/events/event9.jpg",    
    ),
    EventMeeting(
      name: "Cuộc thi \"Nét đẹp thú cưng\"", 
      imgUrl: "assets/images/events/event10.jpg",    
    ),
    EventMeeting(
      name: "Hachiko Festival: Hội Chợ Vì Thú Cưng", 
      imgUrl: "assets/images/events/event11.jpg",    
    ),
    EventMeeting(
      name: "Cuộc thi \"Nét đẹp thú cưng\"", 
      imgUrl: "assets/images/events/event12.jpg",    
    ),
    EventMeeting(
      name: "Hachiko Festival: Hội Chợ Vì Thú Cưng", 
      imgUrl: "assets/images/events/event13.jpg",    
    ),
    EventMeeting(
      name: "Cuộc thi \"Nét đẹp thú cưng\"", 
      imgUrl: "assets/images/events/event14.jpg",    
    ),
    EventMeeting(
      name: "Hachiko Festival: Hội Chợ Vì Thú Cưng", 
      imgUrl: "assets/images/events/event15.jpg",    
    ),
  ]; 
}