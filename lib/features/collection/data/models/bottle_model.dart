class BottleModel {
  int? id;
  String? name;
  String? age;
  String? number;
  String? collection;
  String? status;
  String? image;
  String? bottleIndex;
  Details? details;
  String? notesBy;
  TastingNotes? tastingNotes;
  TastingNotesFull? tastingNotesFull;
  String? videoUrl;
  TastingNotesFull? userNotes;
  String? history;
  List<String>? attachments;
  List<HistoryItems>? historyItems;

  BottleModel({
    this.id,
    this.name,
    this.age,
    this.number,
    this.collection,
    this.status,
    this.image,
    this.bottleIndex,
    this.details,
    this.notesBy,
    this.tastingNotes,
    this.tastingNotesFull,
    this.videoUrl,
    this.userNotes,
    this.history,
    this.attachments,
    this.historyItems,
  });

  BottleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    number = json['number'];
    collection = json['collection'];
    status = json['status'];
    image = json['image'];
    bottleIndex = json['bottleIndex'];
    details = json['details'] != null
        ? Details.fromJson(json['details'])
        : null;
    notesBy = json['notesBy'];
    tastingNotes = json['tastingNotes'] != null
        ? TastingNotes.fromJson(json['tastingNotes'])
        : null;
    tastingNotesFull = json['tastingNotesFull'] != null
        ? TastingNotesFull.fromJson(json['tastingNotesFull'])
        : null;
    videoUrl = json['videoUrl'];
    userNotes = json['userNotes'] != null
        ? TastingNotesFull.fromJson(json['userNotes'])
        : null;
    history = json['history'];
    attachments = json['attachments'].cast<String>();
    if (json['historyItems'] != null) {
      historyItems = <HistoryItems>[];
      json['historyItems'].forEach((v) {
        historyItems!.add(HistoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['number'] = number;
    data['collection'] = collection;
    data['status'] = status;
    data['image'] = image;
    data['bottleIndex'] = bottleIndex;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    data['notesBy'] = notesBy;
    if (tastingNotes != null) {
      data['tastingNotes'] = tastingNotes!.toJson();
    }
    if (tastingNotesFull != null) {
      data['tastingNotesFull'] = tastingNotesFull!.toJson();
    }
    data['videoUrl'] = videoUrl;
    if (userNotes != null) {
      data['userNotes'] = userNotes!.toJson();
    }
    data['history'] = history;
    data['attachments'] = attachments;
    if (historyItems != null) {
      data['historyItems'] = historyItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? distillery;
  String? region;
  String? country;
  String? type;
  String? ageStatement;
  String? filled;
  String? bottled;
  String? caskNumber;
  String? aBV;
  String? size;
  String? finish;

  Details({
    this.distillery,
    this.region,
    this.country,
    this.type,
    this.ageStatement,
    this.filled,
    this.bottled,
    this.caskNumber,
    this.aBV,
    this.size,
    this.finish,
  });

  Details.fromJson(Map<String, dynamic> json) {
    distillery = json['Distillery'];
    region = json['Region'];
    country = json['Country'];
    type = json['Type'];
    ageStatement = json['Age statement'];
    filled = json['Filled'];
    bottled = json['Bottled'];
    caskNumber = json['Cask number'];
    aBV = json['ABV'];
    size = json['Size'];
    finish = json['Finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Distillery'] = distillery;
    data['Region'] = region;
    data['Country'] = country;
    data['Type'] = type;
    data['Age statement'] = ageStatement;
    data['Filled'] = filled;
    data['Bottled'] = bottled;
    data['Cask number'] = caskNumber;
    data['ABV'] = aBV;
    data['Size'] = size;
    data['Finish'] = finish;
    return data;
  }
}

class TastingNotes {
  String? nose;
  String? palate;
  String? finish;

  TastingNotes({this.nose, this.palate, this.finish});

  TastingNotes.fromJson(Map<String, dynamic> json) {
    nose = json['Nose'];
    palate = json['Palate'];
    finish = json['Finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Nose'] = nose;
    data['Palate'] = palate;
    data['Finish'] = finish;
    return data;
  }
}

class TastingNotesFull {
  List<String>? nose;
  List<String>? palate;
  List<String>? finish;

  TastingNotesFull({this.nose, this.palate, this.finish});

  TastingNotesFull.fromJson(Map<String, dynamic> json) {
    nose = json['Nose'].cast<String>();
    palate = json['Palate'].cast<String>();
    finish = json['Finish'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Nose'] = nose;
    data['Palate'] = palate;
    data['Finish'] = finish;
    return data;
  }
}

class HistoryItems {
  String? label;
  String? title;
  List<String>? descriptions;
  List<String>? attachments;

  HistoryItems({this.label, this.title, this.descriptions, this.attachments});

  HistoryItems.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    title = json['title'];
    descriptions = json['descriptions'].cast<String>();
    attachments = json['attachments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['title'] = title;
    data['descriptions'] = descriptions;
    data['attachments'] = attachments;
    return data;
  }
}
