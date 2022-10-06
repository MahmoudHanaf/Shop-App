class Card 
{
   int ? id;
   String ? title ;
   num ? price;
   String ?image ;
   int ?quantity ;
  Card();

  Card.fromJson(Map<String,dynamic> data)
  {
     id =data['id'];
    title =data['title'];
    price =data['price'];
    image =data['image'];
    quantity =data['quantity'];
  }

  Map<String,dynamic> toJson (){
     return {
      "id": id,
      "title": title,
      "price": price,
      "image": image,
      "quantity":quantity,
    };
  }

}