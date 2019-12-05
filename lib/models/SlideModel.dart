class SlideModel {
  String status;
  String msg;
  List<Slides> slides;

  SlideModel({this.status, this.msg, this.slides});

  SlideModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['slides'] != null) {
      slides = new List<Slides>();
      json['slides'].forEach((v) {
        slides.add(new Slides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.slides != null) {
      data['slides'] = this.slides.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slides {
  String slidesImgUrl;
  String directToUrl;
  String type;

  Slides({this.slidesImgUrl, this.directToUrl, this.type});

  Slides.fromJson(Map<String, dynamic> json) {
    slidesImgUrl = json['slides_img_url'];
    directToUrl = json['direct_to_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slides_img_url'] = this.slidesImgUrl;
    data['direct_to_url'] = this.directToUrl;
    data['type'] = this.type;
    return data;
  }
}
