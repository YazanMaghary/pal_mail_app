import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/home_controller.dart';
import 'package:pal_mail_app/controller/tags_controller.dart';
import '../constants/colors.dart';
import '../models/mails_model.dart';
import '../models/tage_model.dart';

class TagsProvider extends ChangeNotifier {
  final TagsHelper _helper = TagsHelper.instance;
  List<bool> _selected = [];
  Set<Tag> _tags = {};
  Set<String> _tagsName = {};
  List<int> _tagsIdSelected = [];
  List<Mail> _mailByTags = [];
  int _tagsIdSelectedForSearch = 0;
  Set<Tag> get tags => _tags;
  bool tagsSelected = false;
  final homehelper = HomeHelper.instance;
  List<int> get tagsId => _tagsIdSelected;
  List<Mail> get mailByTags => _mailByTags;
  int get tagsIdForSearch => _tagsIdSelectedForSearch;
  Set<String> get tagsName => _tagsName;
  List<bool> get selected => _selected;
  Color tagButtonColor = tagButtonColornotSelected;
  Future<void> createTags({required String name}) async {
    await _helper.createTags({'name': name});
    _tagsName.add(name);
    notifyListeners();
  }

  Future<void> getTagsProv() async {
    await _helper.getTags().then((value) {
      for (var element in value.tags!) {
        _tags.add(element);
        _tagsName.add(element.name!);
      }
    });
    notifyListeners();
  }

  Future<void> isSelected() async {
    for (var i = 0; i < tagsName.length; i++) {
      _selected.add(false);
    }
  }

  void isSelectedState(int index) {
    _selected[index] = !_selected[index];

    if (_selected[index]) {
      _tagsIdSelected.add(tags.elementAt(index).id!);
    } else {
      _tagsIdSelected.remove(tags.elementAt(index).id);
    }
    notifyListeners();
  }

  // SearchTags
  TagsColorChange() {
    tagsSelected = !tagsSelected;
    if (tagsSelected == false) {
      tagButtonColor = tagButtonColornotSelected;
    } else {
      tagButtonColor = tagButtonColorSelected;
    }
    notifyListeners();
  }

  void isSelectedStateForSearch(int index) {
    _tagsIdSelectedForSearch = 0;
    _selected[index] = !_selected[index];
    if (_selected[index]) {
      for (var i = 0; i < _selected.length - 1; i++) {
        if (index != i) {
          _selected[i] = false;
        }
      }
      _tagsIdSelectedForSearch = tags.elementAt(index).id!;
    } else {}
    notifyListeners();
  }

  void selectedBefore(int id) {
    _tagsIdSelectedForSearch = id;

    notifyListeners();
  }

  Future<void> mailFilterByTagId() async {
    _mailByTags.clear();
    final response = await homehelper.getMails().then((value) {
      for (var i = 0; i < value.mails!.length; i++) {
        for (var j = 0; j < value.mails![i].tags!.length; j++) {
          if (value.mails![i].tags![j].id == _tagsIdSelectedForSearch) {
            _mailByTags.add(value.mails![i]);
            _mailByTags.forEach((element) {
              print(element.id);
            });
          }
        }
      }
    });

    notifyListeners();
  }

  void clearData() {
    tags.clear();

    tagsName.clear();
    notifyListeners();
  }

  void clearTags() {
    selected.clear();
    tagsId.clear();
    notifyListeners();
  }
}
