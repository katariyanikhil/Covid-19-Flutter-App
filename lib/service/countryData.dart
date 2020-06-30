class Countries {
  List<Stats> stats;

  Countries({this.stats});

  Countries.fromJson(Map<String, dynamic> json) {
    if (json['Countries'] != null) {
      stats = new List<Stats>();
      json['Countries'].forEach((v) {
        if(v['TotalConfirmed'] != 0){
          stats.add(new Stats.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['Stats'] = this.stats.map((v) => v.toJson()).toList();
      return data;
    }else{
      return null;
    }
    
  }
}

class Stats {
  String country;
  int totConfirmed;
  int totDeath;
  int totRecovered;
  int newConfirmed;
  int newDeath;
  int newRecovered;
  String updateDate;

  Stats(
      {this.country,
      this.totConfirmed,
      this.totDeath,
      this.totRecovered,
      this.newConfirmed,
      this.newDeath,
      this.newRecovered,
      this.updateDate});

  Stats.fromJson(Map<String, dynamic> json) {
    country = json['Country'];
    totConfirmed = json['TotalConfirmed'];
    totDeath = json['TotalDeaths'];
    totRecovered = json['TotalRecovered'];
    newConfirmed = json['NewConfirmed'];
    newDeath = json['NewDeaths'];
    newRecovered = json['NewRecovered'];
    updateDate = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Country'] = this.country;
    data['TotalConfirmed'] = this.totConfirmed;
    data['TotalDeaths'] = this.totDeath;
    data['TotalRecovered'] = this.totRecovered;
    data['NewConfirmed'] = this.newConfirmed;
    data['NewDeaths'] = this.newDeath;
    data['NewRecovered'] = this.newRecovered;
    data['Date'] = this.updateDate;
    return data;
  }
}
