class CtrlDomain {
  static final CtrlDomain _singleton =  CtrlDomain._internal();
  factory CtrlDomain() {
    return _singleton;
  }
  CtrlDomain._internal();
}

