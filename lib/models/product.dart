class Product 
{
   int ? id;
   String ? title ;
   num ? price;
   String ?description ;
   String ?category ;
   String ?image ;
   Rating ?rating ;

   Product();

   Product.fromJson(Map<String,dynamic> data)
   {
    id =data['id'];
    title =data['title'];
    price =data['price'];
    description =data['description'];
    category =data['category'];
    image =data['image'];
    rating =Rating.fromJson(data['rating']);
   }

   Map<String ,dynamic> toJson ()
  {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
      "rating": rating?.toJson(),
    };
  }

    
}


class Rating 
{
  double ?rate ;
  int ? count ;

  Rating({this.rate,this.count});

  Rating.fromJson(Map<String ,dynamic> data)
  {
    rate =data['rate'] !=null ? data['rate'] : 0.0;
    count =data['count'];
  }

  Map<String ,dynamic> toJson ()
  {
    return {
      "rate": rate,
      "count": count,
    };
  }

}