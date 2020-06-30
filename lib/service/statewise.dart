class States {
  List<StateWise> stateWise;

  States({this.stateWise});

  States.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      stateWise = new List<StateWise>();
      json['data']['regional'].forEach((v) {
        stateWise.add(new StateWise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stateWise != null) {
      data['StateWise'] = this.stateWise.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateWise {
  String stateName;
  String totConfirmed;
  String totDeath;
  String totRecovered;

  StateWise(
      {this.stateName,
      this.totConfirmed,
      this.totDeath,
      this.totRecovered,
      });

  StateWise.fromJson(Map<String, dynamic> json) {
    stateName = json['loc'];
    totConfirmed = json['totalConfirmed'].toString();
    totDeath = json['deaths'].toString();
    totRecovered = json['discharged'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loc'] = this.stateName;
    data['totalConfirmed'] = this.totConfirmed;
    data['deaths'] = this.totDeath;
    data['discharged'] = this.totRecovered;
    return data;
  }
}