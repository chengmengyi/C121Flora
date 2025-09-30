import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage_name.dart';
import 'package:flora121_package_b/flora_enum/flora121_cash_type.dart';

StorageData<int> bHealthNum=StorageData<int>(key: Flora121StorageName.bHealthNum, defaultValue: 0);
StorageData<int> bCollectEnergyNum=StorageData<int>(key: Flora121StorageName.bCollectEnergyNum, defaultValue: 0);
StorageData<int> bWheelGiftNum=StorageData<int>(key: Flora121StorageName.bWheelGiftNum, defaultValue: 0);
StorageData<int> bDiceLargeIndex=StorageData<int>(key: Flora121StorageName.bDiceLargeIndex, defaultValue: 0);
StorageData<int> bDiceSmallIndex=StorageData<int>(key: Flora121StorageName.bDiceSmallIndex, defaultValue: 0);
StorageData<int> bDiceStepIndex=StorageData<int>(key: Flora121StorageName.bDiceStepIndex, defaultValue: 0);
StorageData<int> bHomeWaterItemCD=StorageData<int>(key: Flora121StorageName.bHomeWaterItemCD, defaultValue: 0);
StorageData<int> bLastTimeMoneyLevel=StorageData<int>(key: Flora121StorageName.bLastTimeMoneyLevel, defaultValue: 0);


StorageData<String> bWheelNum=StorageData<String>(key: Flora121StorageName.bWheelNum, defaultValue: "");
StorageData<String> bSelectCashType=StorageData<String>(key: Flora121StorageName.bSelectCashType, defaultValue: Flora121CashType.paypal);
StorageData<String> bShowNewUserGuideTimer=StorageData<String>(key: Flora121StorageName.bShowNewUserGuideTimer, defaultValue: "");
StorageData<String> bShowOldUserGuideTimer=StorageData<String>(key: Flora121StorageName.bShowOldUserGuideTimer, defaultValue: "");
StorageData<String> bCashTaskConfigStr=StorageData<String>(key: Flora121StorageName.bCashTaskConfigStr, defaultValue: "");
StorageData<String> bValueConfigStr=StorageData<String>(key: Flora121StorageName.bValueConfigStr, defaultValue: "");
StorageData<String> bAdProbabilityConfigStr=StorageData<String>(key: Flora121StorageName.bAdProbabilityConfigStr, defaultValue: "");
StorageData<String> bHasReceivedLevelMoney=StorageData<String>(key: Flora121StorageName.bHasReceivedLevelMoney, defaultValue: "");
StorageData<String> bLastShowHasMoneyDialogTimer=StorageData<String>(key: Flora121StorageName.bLastShowHasMoneyDialogTimer, defaultValue: "");


StorageData<bool> bMoneyStatusOpen=StorageData<bool>(key: Flora121StorageName.bMoneyStatusOpen, defaultValue: true);
StorageData<bool> bShowOpenAd=StorageData<bool>(key: Flora121StorageName.bShowOpenAd, defaultValue: false);
StorageData<bool> bBarrageSwitch=StorageData<bool>(key: Flora121StorageName.bBarrageSwitch, defaultValue: true);


StorageData<double> bMyMoneyNum=StorageData<double>(key: Flora121StorageName.bMyMoneyNum, defaultValue: 0.0);