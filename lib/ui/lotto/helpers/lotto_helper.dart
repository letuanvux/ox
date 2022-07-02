import 'dart:convert';

import '../models/lotto.dart';
import '../models/max_miss_day.dart';
import '../models/bridge.dart';
import '../models/bridge_number.dart';
import '../models/long_number.dart';
import '../models/prize.dart';
import '../models/prize_number.dart';

class ContentType {
  static Map<String, String> form = <String, String>{
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  };
  static Map<String, String> json = <String, String>{
    "Accept": "application/json",
    'Content-Type': 'application/json',
  };
}

class LottoHelper {
  static String getSerial(String? json) {
    if (json?.isNotEmpty ?? true) {
      Map<String, dynamic> data = jsonDecode(json!) as Map<String, dynamic>;
      var serial = data['root']['serial'];
      return serial.toString();
    }
    return '';
  }

  static String getPrize(String? json) {
    if (json?.isNotEmpty ?? true) {
      Map<String, dynamic> data = jsonDecode(json!) as Map<String, dynamic>;
      var serial = data['root']['prizenumber'];
      return serial.toString();
    }
    return '';
  }

  static List<PrizeNumber> getPrizeNumbers(String? json) {
    var prizes = <PrizeNumber>[];
    if (json?.isNotEmpty ?? true) {
      var data = jsonDecode(json!);
      data['root']['prizenumber'].forEach((v) {
        prizes.add(PrizeNumber.fromJson(v));
      });
    }
    return prizes;
  }

  // Lay danh sach du doan
  static List<String> getRandom(int max) {
    var lstNumbers = List<String>.generate(
        max, (i) => i < 9 ? '0${i + 1}' : (i + 1).toString());
    return lstNumbers;
  }

  // Lay danh sach so lau ra
  static Future<List<LongNumber>> getLongNumbers(List<Prize> prizes, int min,
      int max, List<MaxMissDay> maxmissDays) async {
    List<LongNumber> lstItems = [];
    for (var i = min; i <= max; i++) {
      String ab = i <= 9 ? '0$i' : i.toString();
      int days = 0;
      for (Prize item in prizes) {
        var count = getPrizeNumbers(item.json)
            .where((element) => isMatch(ab, element.number) == true)
            .toList()
            .length;
        if (count > 0) {
          break;
        }
        days++;
      }
      lstItems.add(LongNumber(number: ab, maxdays: prizes.length, days: days));
    }
    if (maxmissDays.isNotEmpty) {
      // Cap nhat Max Days
      lstItems.forEach((element) => element.maxdays =
          maxmissDays.where((o) => o.number == element.number).first.maxdays);
    }
    return lstItems;
  }

  static Future<List<MatchNumber>> getDayNumbers(List<Prize> prizes) async {
    List<MatchNumber> lstItems = [];

    for (var i = 0; i < prizes.length; i++) {
      if (i == 0) {
        var numbers = getPrizeNumbers(prizes[i].json);
        for (var item in numbers) {
          if (lstItems
              .where((element) =>
                  element.number ==
                  item.number.substring(item.number.length - 2))
              .isEmpty) {
            lstItems.add(MatchNumber(
                number: item.number.substring(item.number.length - 2),
                days: 1));
          }
        }
      } else {
        var lst = lstItems.where((element) => element.days >= i).toList();
        if (lst.isNotEmpty) {
          List<PrizeNumber> numbers = getPrizeNumbers(prizes[i].json);
          for (var item in lstItems) {
            if (numbers.where((o) => o.number == item.number).isNotEmpty) {
              // Cap nhat Days
              item.days += 1;
            }
          }
        } else {
          break;
        }
      }
    }
    lstItems.sort((a, b) => b.days.compareTo(a.days));
    return lstItems;
  }

  static Future<List<TripleNumber>> getTripleNumbers(
      List<Prize> prizes, int min, int max) async {
    List<PrizeNumber> prizeNumbers = [];
    List<TripleNumber> lstItems = [];

    for (Prize item in prizes) {
      prizeNumbers.addAll(getPrizeNumbers(item.json));
    }

    // Lay danh sach nhung so co do dai 3 so
    prizeNumbers =
        prizeNumbers.where((element) => element.number.length > 2).toList();

    for (var i = min; i <= max; i++) {
      String ab = i <= 9 ? '0$i' : i.toString();
 
      lstItems.add(TripleNumber(
        number: ab,
        items: prizeNumbers.where((element) => element.number.endsWith(ab))
          .map((item) => item.number.substring(item.number.length - 3, item.number.length - 2)).toList(),
      ));
    }

    return lstItems;
  }

  static Future<List<MaxMissDay>> getMaxMissDays(
      Lotto lotto, List<Prize> prizes) async {
    List<MaxMissDay> lstItems = [];
    for (var i = lotto.min; i <= lotto.max; i++) {
      String ab = i <= 9 ? '0$i' : i.toString();
      int days = 0;
      int maxdays = 0;
      for (Prize item in prizes) {
        var isHas = isHasNumber(item, ab, 2, false);
        if (isHas) {
          maxdays = maxdays < days ? days : maxdays;
          days = 0;
        } else {
          days++;
        }
      }
      lstItems.add(MaxMissDay(
        lotto: lotto.id,
        number: ab,
        maxdays: maxdays,
      ));
    }
    return lstItems;
  }

  // Check match number
  static bool isMatch(String value, String number) {
    return number.endsWith(value) ? true : false;
  }

  static Future<List<LottoBridge>> getBridges(
      List<Prize> prizes, bool isReverse, bool isUnique) async {
    List<LottoBridge> lstBridges = [];
    for (var i = 0; i < prizes.length; i++) {
      if (i + 1 < prizes.length) {
        var newPrize = prizes[i];
        var oldPrize = prizes[i + 1];
        if (i == 0) {
          // Tim cau
          lstBridges = findBridges(newPrize, oldPrize, isReverse)
              .where((o) => o.isHasBridge == true)
              .toList();
        } else {
          //kiem tra xem con cau ko thi tiep tuc loc
          var isHasBridge =
              lstBridges.where((o) => o.isHasBridge == true).isNotEmpty
                  ? true
                  : false;
          if (isHasBridge) {
            filterBridges(lstBridges, newPrize, oldPrize, isReverse);
          } else {
            //Thoat khoi vong for
            break;
          }
        }
      }
    }
    // Sort descending
    lstBridges.sort((a, b) => b.days.compareTo(a.days));

    if (isUnique) {
      lstBridges = unique(lstBridges);
    }

    return lstBridges.where((element) => element.days > 1).toList();    
  }

  static List<LottoBridge> unique(List<LottoBridge> bridges) {
    var lstUniques = <LottoBridge>[];
    for (var i = 0; i < bridges.length; i++) {
      if (lstUniques
          .where((o) => o.nextnumber == bridges[i].nextnumber)
          .isEmpty) {
        lstUniques.add(bridges[i]);
      }
    }
    return lstUniques;
  }

  static String getNumberWithBridge(Prize prize, LottoBridge bridge) {
    return getNumber(prize, bridge.prefix.group, bridge.prefix.position,
            bridge.prefix.index) +
        getNumber(prize, bridge.suffix.group, bridge.suffix.position,
            bridge.suffix.index);
  }

  static String getNumberTriple(Prize prize, LottoBridge bridge) {
    return bridge.option == null
        ? ""
        : getNumber(prize, bridge.option!.group, bridge.option!.position,
                bridge.option!.index) +
            getNumber(prize, bridge.prefix.group, bridge.prefix.position,
                bridge.prefix.index) +
            getNumber(prize, bridge.suffix.group, bridge.suffix.position,
                bridge.suffix.index);
  }

  static String getNumber(Prize prize, int group, int position, int index) {
    var item = getPrizeNumbers(prize.json)
        .where((o) => o.group == group && o.position == position)
        .single;
    var number = item.number.substring(index, index + 1);
    return number;
  }

  static bool isHasNumber(
      Prize prize, String number, int length, bool isReverse) {
    var count = countNumber(prize, number, length, isReverse);
    return count > 0 ? true : false;
  }

  static int countNumber(
      Prize prize, String number, int length, bool isReverse) {
    var lstPrizeNumbers = getPrizeNumbers(prize.json);
    var count = lstPrizeNumbers
        .where((o) => o.number.length >= length)
        .where((o) => o.number.endsWith(number))
        .length;

    var reverse = number.split('').reversed.join();
    if (isReverse && number != reverse) {
      count += lstPrizeNumbers.where((o) => o.number.endsWith(reverse)).length;
    }
    return count;
  }

  static Future<List<LottoBridge>> getTriples(
      List<Prize> prizes, bool isReverse, bool isUnique) async {
    List<LottoBridge> lstItems = [];
    // Lay danh sach cau 2 so
    var bridges = await getBridges(prizes, isReverse, isUnique);
    // Loc danh sach cau 3 so
    for (var i = 0; i < prizes.length; i++) {
      if (i + 1 < prizes.length) {
        var newPrize = prizes[i];
        var oldPrize = prizes[i + 1];
        if (i == 0) {
          // Find Triples
          var lstPrizeNumbers = getPrizeNumbers(oldPrize.json);
          for (var objOption in lstPrizeNumbers) {
            for (int iOption = 0;
                iOption < objOption.number.length;
                iOption++) {
              //Thong tin so option
              String optionNumber =
                  objOption.number.substring(iOption, iOption + 1);
              for (int i = 0; i < bridges.length; i++) {
                var times = countNumber(
                    newPrize, optionNumber + bridges[i].number, 3, false);
                if (times > 0) {
                  //Thong tin so triple
                  var item = LottoBridge(
                    lotto: newPrize.lotto,
                    drawtime: newPrize.drawtime,
                  );
                  item.option = BridgeNumber(
                      group: objOption.group,
                      position: objOption.position,
                      index: iOption);
                  item.prefix = bridges[i].prefix;
                  item.suffix = bridges[i].suffix;
                  item.fromtime = newPrize.drawtime;
                  item.days = 1;
                  item.times = times;
                  item.isHasBridge = true;
                  item.number = getNumber(oldPrize, objOption.group,
                          objOption.position, iOption) +
                      bridges[i].number;
                  //Thong tin so du doan
                  item.nextnumber = getNumber(newPrize, objOption.group,
                          objOption.position, iOption) +
                      bridges[i].nextnumber;
                  lstItems.add(item);
                }
              }
            }
          }
        } else {
          //Filter
          //kiem tra xem con cau ko thi tiep tuc loc
          var isHasBridge =
              lstItems.where((o) => o.isHasBridge == true).isNotEmpty
                  ? true
                  : false;
          if (isHasBridge) {
            filterTriples(lstItems, newPrize, oldPrize);
          } else {
            //Thoat khoi vong for
            break;
          }
        }
      }
    }

    lstItems.sort((a, b) => b.days.compareTo(a.days));

    if (isUnique) {
      lstItems = unique(lstItems);
    }

    return lstItems.where((element) => element.days > 1).toList();
  }

  static List<LottoBridge> findBridges(
      Prize newPrize, Prize oldPrize, bool isReverse) {
    List<LottoBridge> lstBridges = [];
    var lstPrizeNumbers = getPrizeNumbers(oldPrize.json);
    for (var objPrefix in lstPrizeNumbers) {
      for (int iPrefix = 0; iPrefix < objPrefix.number.length; iPrefix++) {
        for (var objSuffix in lstPrizeNumbers) {
          for (int iSuffix = 0; iSuffix < objSuffix.number.length; iSuffix++) {
            if ((objPrefix.group == objSuffix.group &&
                    objPrefix.position == objSuffix.position &&
                    iPrefix == iSuffix) ==
                false) {
              //Thong tin cau tim thay
              var bridge = LottoBridge(
                lotto: newPrize.lotto,
                drawtime: newPrize.drawtime,
              );
              //Thong tin so dau
              bridge.prefix = BridgeNumber(
                  group: objPrefix.group,
                  position: objPrefix.position,
                  index: iPrefix);
              //Thong tin so cuoi
              bridge.suffix = BridgeNumber(
                  group: objSuffix.group,
                  position: objSuffix.position,
                  index: iSuffix);
              //Thong tin so du doan
              String nextPrefixNumber = getNumber(
                  newPrize, objPrefix.group, objPrefix.position, iPrefix);
              String nextSuffixNumber = getNumber(
                  newPrize, objSuffix.group, objSuffix.position, iSuffix);
              bridge.number = nextPrefixNumber + nextSuffixNumber;

              //Thong tin so dau va so cuoi
              String prefixNumber =
                  objPrefix.number.substring(iPrefix, iPrefix + 1);
              String suffixNumber =
                  objSuffix.number.substring(iSuffix, iSuffix + 1);
              var times = countNumber(
                  newPrize, prefixNumber + suffixNumber, 2, isReverse);
              if (times > 0) {
                bridge.days = 1;
                bridge.times = times;
                bridge.isHasBridge = true;
              }
              //Add bridge to list
              lstBridges.add(bridge);
            }
          }
        }
      }
    }
    return lstBridges;
  }

  static List<LottoBridge> filterBridges(List<LottoBridge> bridges,
      Prize newPrize, Prize oldPrize, bool isReverse) {
    // Lay cac cau con chay
    bridges = bridges.where((o) => o.isHasBridge == true).toList();
    for (int i = 0; i < bridges.length; i++) {
      var bridge = bridges[i];
      if (bridges[i].isHasBridge) {
        String prefixNumber = getNumber(oldPrize, bridge.prefix.group,
            bridge.prefix.position, bridge.prefix.index);
        String suffixNumber = getNumber(oldPrize, bridge.suffix.group,
            bridge.suffix.position, bridge.suffix.index);
        var times =
            countNumber(newPrize, prefixNumber + suffixNumber, 2, isReverse);
        if (times > 0) {
          bridges[i].days += 1;
          bridges[i].times += times;
          bridges[i].fromtime = oldPrize.drawtime;
        } else {
          bridges[i].isHasBridge = false;
        }
      }
    }
    return bridges;
  }

  static String markBridge(PrizeNumber prize, LottoBridge? bridge) {
    if (bridge != null) {
      var prefix = bridge.prefix;
      var suffix = bridge.suffix;
      if (prize.group == prefix.group &&
          prize.position == prefix.position &&
          prefix.group == suffix.group &&
          prefix.position == suffix.position) {
        if (prefix.index < suffix.index) {
          return prize.number.substring(0, prefix.index) +
              markNumber(prize.number, prefix.index, '¹') +
              prize.number.substring(prefix.index + 1, suffix.index) +
              markNumber(prize.number, suffix.index, '²') +
              prize.number.substring(suffix.index + 1);
        } else {
          return prize.number.substring(0, suffix.index) +
              markNumber(prize.number, suffix.index, '²') +
              prize.number.substring(suffix.index + 1, prefix.index) +
              markNumber(prize.number, prefix.index, '¹') +
              prize.number.substring(prefix.index + 1);
        }
      }

      if (prize.group == prefix.group && prize.position == prefix.position) {
        return prize.number.substring(0, prefix.index) +
            markNumber(prize.number, prefix.index, '¹') +
            prize.number.substring(prefix.index + 1);
      } else if (prize.group == suffix.group &&
          prize.position == suffix.position) {
        return prize.number.substring(0, suffix.index) +
            markNumber(prize.number, suffix.index, '²') +
            prize.number.substring(suffix.index + 1);
      }
    }
    return prize.number;
  }

  static markNumber(String number, int index, String symbol) {
    return symbol + '⌜' + number.substring(index, index + 1) + '⌟';
  }

  static List<LottoBridge> filterTriples(
      List<LottoBridge> bridges, Prize newPrize, Prize oldPrize) {
    // Lay cac cau con chay
    bridges = bridges.where((o) => o.isHasBridge == true).toList();
    for (int i = 0; i < bridges.length; i++) {
      var bridge = bridges[i];
      if (bridges[i].isHasBridge) {
        String optionNumber = getNumber(oldPrize, bridge.option!.group,
            bridge.option!.position, bridge.option!.index);
        String prefixNumber = getNumber(oldPrize, bridge.prefix.group,
            bridge.prefix.position, bridge.prefix.index);
        String suffixNumber = getNumber(oldPrize, bridge.suffix.group,
            bridge.suffix.position, bridge.suffix.index);
        var times = countNumber(
            newPrize, optionNumber + prefixNumber + suffixNumber, 3, false);
        if (times > 0) {
          bridges[i].days += 1;
          bridges[i].times += times;
          bridges[i].fromtime = oldPrize.drawtime;
        } else {
          bridges[i].isHasBridge = false;
        }
      }
    }
    return bridges;
  }
  
}

