class CtrlPresentation {
  static final CtrlPresentation _singleton =  CtrlPresentation._internal();
  factory CtrlPresentation() {
    return _singleton;
  }
  CtrlPresentation._internal();
}