class OnBoardingPageModel {
  String id;
  String image;
  String title;
  String text;
  String link;
  String sort;
  String created;
  String active;

  OnBoardingPageModel(
      {this.id,
        this.image,
        this.title,
        this.text,
        this.link,
        this.sort,
        this.created,
        this.active});

  OnBoardingPageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    image = json['image'].toString();
    title = json['title'].toString();
    text = json['text'].toString();
    link = json['link'].toString();
    sort = json['sort'].toString();
    created = json['created'].toString();
    active = json['active'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['text'] = this.text;
    data['link'] = this.link;
    data['sort'] = this.sort;
    data['created'] = this.created;
    data['active'] = this.active;
    return data;
  }
}