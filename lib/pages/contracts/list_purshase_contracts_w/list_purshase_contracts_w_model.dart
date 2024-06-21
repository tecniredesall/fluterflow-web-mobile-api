import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/base/side_nav/side_nav_widget.dart';
import '/components/contracts/pop_over_menu_contract/pop_over_menu_contract_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'list_purshase_contracts_w_widget.dart'
    show ListPurshaseContractsWWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListPurshaseContractsWModel
    extends FlutterFlowModel<ListPurshaseContractsWWidget> {
  ///  Local state fields for this page.

  int? totalElements;

  int? index = 0;

  bool isShowFullList = true;

  List<ContractsStruct> listContracts = [];
  void addToListContracts(ContractsStruct item) => listContracts.add(item);
  void removeFromListContracts(ContractsStruct item) =>
      listContracts.remove(item);
  void removeAtIndexFromListContracts(int index) =>
      listContracts.removeAt(index);
  void insertAtIndexInListContracts(int index, ContractsStruct item) =>
      listContracts.insert(index, item);
  void updateListContractsAtIndex(
          int index, Function(ContractsStruct) updateFn) =>
      listContracts[index] = updateFn(listContracts[index]);

  List<ContractsStruct> listContractsFiltered = [];
  void addToListContractsFiltered(ContractsStruct item) =>
      listContractsFiltered.add(item);
  void removeFromListContractsFiltered(ContractsStruct item) =>
      listContractsFiltered.remove(item);
  void removeAtIndexFromListContractsFiltered(int index) =>
      listContractsFiltered.removeAt(index);
  void insertAtIndexInListContractsFiltered(int index, ContractsStruct item) =>
      listContractsFiltered.insert(index, item);
  void updateListContractsFilteredAtIndex(
          int index, Function(ContractsStruct) updateFn) =>
      listContractsFiltered[index] = updateFn(listContractsFiltered[index]);

  String? selectFilterCommodity;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Contracts)] action in ListPurshaseContractsW widget.
  ApiCallResponse? responseContracts;
  // Stores action output result for [Custom Action - parseListContracts] action in ListPurshaseContractsW widget.
  List<ContractsStruct>? contractsParsed;
  // Model for sideNav component.
  late SideNavModel sideNavModel;
  // State field(s) for textToSearch widget.
  FocusNode? textToSearchFocusNode;
  TextEditingController? textToSearchTextController;
  String? Function(BuildContext, String?)? textToSearchTextControllerValidator;
  String? _textToSearchTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 3) {
      return 'Mínimo 3 caracteres';
    }
    if (val.length > 20) {
      return 'Máximo 20 caracteres';
    }

    return null;
  }

  // Stores action output result for [Custom Action - searchContractsTable] action in SearchButton widget.
  List<ContractsStruct>? returnList;
  // Stores action output result for [Custom Action - filterContracts] action in Button widget.
  List<ContractsStruct>? returnListContractFiltered;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<ContractsStruct>();

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
    textToSearchTextControllerValidator = _textToSearchTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideNavModel.dispose();
    textToSearchFocusNode?.dispose();
    textToSearchTextController?.dispose();
  }
}
