enum Status { initial, loading, success, failure, networkError, empty }

extension StatusExtension on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isLoadingOrInitial =>
      [Status.loading, Status.initial].contains(this);
  bool get isAnyError => [Status.networkError, Status.failure].contains(this);
  bool get isEmpty => this == Status.empty;
  bool get isNetworkError => this == Status.networkError;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

enum Pagination { match, loading, notMatch }

enum PopUpActions { delete, edit }

extension PaginationExtension on Pagination {
  bool get isLoading => this == Pagination.loading;
  bool get isMatch => this == Pagination.match;
  bool get isNotMatch => this == Pagination.notMatch;
}

enum FilterCustomer { none, noneVisited, dueDate, nearest }

extension FilterCustomerExtension on FilterCustomer {
  bool get isNone => this == FilterCustomer.none;
  bool get isNoneVisited => this == FilterCustomer.noneVisited;
  bool get isDueDate => this == FilterCustomer.dueDate;
  bool get isNearest => this == FilterCustomer.nearest;
}

enum ShowMessageEnum {
  showFailedAlert,
  showSuccessAlert,
  showBothAlert,
  showfailedToast,
  showSuccessToast,
  showBothToast,
  showFailedAlertSuccessToast,
  showFailedToastSuccessAlert,
  none
}

enum ShowLoading { Show, No }

extension ShowMessageEnumExtension on ShowMessageEnum {
  bool get nono => [
        ShowMessageEnum.none,
      ].contains(this);
  bool get successAlert => [
        ShowMessageEnum.showSuccessAlert,
        ShowMessageEnum.showBothAlert,
        ShowMessageEnum.showFailedToastSuccessAlert
      ].contains(this);
  bool get failedAlert => [
        ShowMessageEnum.showFailedAlert,
        ShowMessageEnum.showBothAlert,
        ShowMessageEnum.showFailedAlertSuccessToast
      ].contains(this);
  bool get failedToast => [
        ShowMessageEnum.showBothToast,
        ShowMessageEnum.showfailedToast,
        ShowMessageEnum.showFailedToastSuccessAlert
      ].contains(this);

  bool get successToast => [
        ShowMessageEnum.showBothToast,
        ShowMessageEnum.showSuccessToast,
        ShowMessageEnum.showFailedAlertSuccessToast
      ].contains(this);
}

enum ParseBody { direct, row, towLevelList }

enum DataSource { local, remote, checkNetwork }

extension DataSourceExtension on DataSource {
  bool get isRemote => this == DataSource.remote;
  bool get isLocal => this == DataSource.local;
  bool get isCheckNetwork => this == DataSource.checkNetwork;
}

/// to check database table type
/// for sembast database
enum DataBaseType { Integer, Strings }

//used in get default operation message
enum OperationType {
  SuccessGetAll,
  SuccessGetOne,
  SuccessAddAll,
  SuccessAddOne,
  SuccessUpdate,
  SuccessDelete,
  FailedAddAll,
  FailedGetAll,
  FailedGetOne,
  FailedAddOne,
  FailedUpdate,
  FailedDelete,
}

enum RefreshStatus { wating, loading, error, success }

extension RefreshStatusExtension on RefreshStatus {
  bool get isWatting => this == RefreshStatus.wating;
  bool get isError => this == RefreshStatus.error;
  bool get isSuccess => this == RefreshStatus.success;
  bool get isLoading => this == RefreshStatus.loading;
}

enum ElementType { doctor, pharmacy, laboratory, settings}
