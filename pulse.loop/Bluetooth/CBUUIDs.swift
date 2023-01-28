//
//  CBUUIDs.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import CoreBluetooth
import Foundation

struct CBUUIDs {
    
    // MARK: Services
    
    // | Service            | UUID     |
    // |--------------------|----------|
    // | Battery            | `0x180F` |
    // | Current Time       | `0x1805` |
    // | Device Information | `0x180A` |
    // | Heart Rate         | `0x180D` |
    // | Pulse Oximeter     | `0x1822` |
    
    // | Service                        | UUID                                   |
    // |--------------------------------|----------------------------------------|
    // | Firmware upgrade               | `0BA1B4AC-734A-4E75-AD22-8D5BBDEA5025` |
    // | Historic data                  | `DE753059-8906-4F07-A192-12879BB84DA7` |
    // | Optical frontend configuration | `C8F276D4-E0DD-4660-8070-619FF734134B` |
    // | Raw sensor data                | `272DF1F7-9D28-4B8C-86F6-30DB30ACE42C` |
    // | Settings                       | `821198C8-3036-4E14-B01C-364F2B20C603` |
    // | pulse.loop identifier          | `68D68245-CFD8-4A1C-9858-B27ABC4C382E` |
    
    static private let kUUIDServiceBattery = "0x180F"
    static private let kUUIDServiceCurrentTime = "0x1805"
    static private let kUUIDServiceDeviceInformation = "0x180A"
    static private let kUUIDServiceHeartRate = "0x180D"
    static private let kUUIDServicePulseOximeter = "0x1822"
    static private let kUUIDServiceFirmwareUpgrade = "0BA1B4AC-734A-4E75-AD22-8D5BBDEA5025"
    static private let kUUIDServiceHistoricData = "DE753059-8906-4F07-A192-12879BB84DA7"
    static private let kUUIDServiceOpticalFrontendConfiguration = "C8F276D4-E0DD-4660-8070-619FF734134B"
    static private let kUUIDServiceRawSensorData = "272DF1F7-9D28-4B8C-86F6-30DB30ACE42C"
    static private let kUUIDServiceSettings = "821198C8-3036-4E14-B01C-364F2B20C603"
    static private let kUUIDServicePulseLoopIdentifier = "68D68245-CFD8-4A1C-9858-B27ABC4C382E"

    static let batteryServiceIdentifier = CBUUID(string: kUUIDServiceBattery)
    static let currentTimeServiceIdentifier = CBUUID(string: kUUIDServiceCurrentTime)
    static let deviceInformationServiceIdentifier = CBUUID(string: kUUIDServiceDeviceInformation)
    static let heartRateServiceIdentifier = CBUUID(string: kUUIDServiceHeartRate)
    static let pulseOximeterServiceIdentifier = CBUUID(string: kUUIDServicePulseOximeter)
    static let firmwareUpgradeServiceIdentifier = CBUUID(string: kUUIDServiceFirmwareUpgrade)
    static let historicDataServiceIdentifier = CBUUID(string: kUUIDServiceHistoricData)
    static let opticalFrontendConfigurationServiceIdentifier = CBUUID(string: kUUIDServiceOpticalFrontendConfiguration)
    static let rawSensorDataServiceIdentifier = CBUUID(string: kUUIDServiceRawSensorData)
    static let settingsServiceIdentifier = CBUUID(string: kUUIDServiceSettings)
    static let pulseLoopIdentifierServiceIdentifier = CBUUID(string: kUUIDServicePulseLoopIdentifier)
    
    // MARK: pulse.loop identifier service
    
    // | Characteristic | Access | UUID                                   |
    // |----------------|--------|----------------------------------------|
    // | Version        | Read   | `1852299D-AE64-4E4F-B915-CB37E7FD57C9` |
    
    static private let kUUIDCharacteristicVersion = "1852299D-AE64-4E4F-B915-CB37E7FD57C9"

    static let versionCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicVersion)
    
    // MARK: Raw sensor data service
    
    // | Characteristic        | Access | UUID                                   |
    // |-----------------------|--------|----------------------------------------|
    // | Ambient phase reading | Read   | `33EAF25F-7A5C-4327-A95B-B602DA54C443` |
    // | LED1 - Ambient        | Read   | `CF66D344-584D-4E67-AC30-17D28B099A30` |
    // | LED1 ADC reading      | Read   | `05500B81-516D-4BD9-95BA-C0B87C911DDB` |
    // | LED2 ADC reading      | Read   | `A93B639D-8A8D-43EA-8A5A-8175D7C09E0B` |
    // | LED3 ADC reading      | Read   | `C0A12246-79E4-4BD7-8A4F-B841D5590F70` |
    // | Aggregated data       | Read   | `26CB3CCA-F22E-4179-8125-55874E9153AD` |
    
    static private let kUUIDCharacteristicAmbientADCReading = "33EAF25F-7A5C-4327-A95B-B602DA54C443"
    static private let kUUIDCharacteristicLED1MinusAmbient = "CF66D344-584D-4E67-AC30-17D28B099A30"
    static private let kUUIDCharacteristicLED1ADCReading = "05500B81-516D-4BD9-95BA-C0B87C911DDB"
    static private let kUUIDCharacteristicLED2ADCReading = "A93B639D-8A8D-43EA-8A5A-8175D7C09E0B"
    static private let kUUIDCharacteristicLED3ADCReading = "C0A12246-79E4-4BD7-8A4F-B841D5590F70"
    static private let kUUIDCharacteristicAggregatedDataReading = "26CB3CCA-F22E-4179-8125-55874E9153AD"

    static let ambientADCReadingCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientADCReading)
    static let led1MinusAmbientCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1MinusAmbient)
    static let led1ADCReadingCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1ADCReading)
    static let led2ADCReadingCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2ADCReading)
    static let led3ADCReadingCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3ADCReading)
    static let aggregatedDataReadingCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAggregatedDataReading)
    // MARK Optical frontend configuration service
    
    // | Characteristic               | Access     | UUID                                   |
    // |------------------------------|------------|----------------------------------------|
    // | Ambient ADC conversion end   | Read/Write | `9B6AF28C-9558-49ED-844B-06E7B8B0E6C3` |
    // | Ambient ADC conversion start | Read/Write | `66DC5EDA-B89E-43D5-B940-13E29A468C77` |
    // | Ambient ADC reset end        | Read/Write | `E9AB33D4-DA9C-4424-851A-16CF66AA08C0` |
    // | Ambient ADC reset start      | Read/Write | `FD7FAFE2-4464-4F8C-A55C-79E45FB916B3` |
    // | Ambient offset current       | Read/Write | `4ED69FED-8261-4931-A8A4-CA67B406A73A` |
    // | Ambient sample end           | Read/Write | `83C29A09-B658-4316-A1FD-D8AD97C02F80` |
    // | Ambient sample start         | Read/Write | `C35EBCC5-BCA4-4716-90E3-37B94D9AD6FF` |
    
    static private let kUUIDCharacteristicAmbientADCConversionEnd = "9B6AF28C-9558-49ED-844B-06E7B8B0E6C3"
    static private let kUUIDCharacteristicAmbientADCConversionStart = "66DC5EDA-B89E-43D5-B940-13E29A468C77"
    static private let kUUIDCharacteristicAmbientADCResetEnd = "E9AB33D4-DA9C-4424-851A-16CF66AA08C0"
    static private let kUUIDCharacteristicAmbientADCResetStart = "FD7FAFE2-4464-4F8C-A55C-79E45FB916B3"
    static private let kUUIDCharacteristicAmbientOffsetCurrent = "4ED69FED-8261-4931-A8A4-CA67B406A73A"
    static private let kUUIDCharacteristicAmbientSampleEnd = "83C29A09-B658-4316-A1FD-D8AD97C02F80"
    static private let kUUIDCharacteristicAmbientSampleStart = "C35EBCC5-BCA4-4716-90E3-37B94D9AD6FF"

    static let ambientADCConversionEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientADCConversionEnd)
    static let ambientADCConversionStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientADCConversionStart)
    static let ambientADCResetEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientADCResetEnd)
    static let ambientADCResetStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientADCResetStart)
    static let ambientOffsetCurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientOffsetCurrent)
    static let ambientSampleEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientSampleEnd)
    static let ambientSampleStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicAmbientSampleStart)
    
    // | Characteristic               | Access     | UUID                                   |
    // |------------------------------|------------|----------------------------------------|
    // | ADC averages                 | Read/Write | `7ADE19EA-2202-48E1-AFFB-4D8504024C37` |
    // | Decimation factor            | Read/Write | `4D5A0E9C-0164-4D65-8F2D-86741B820EEF` |
    // | Dynamic power-down end       | Read/Write | `BC276997-792F-4391-9371-78F1C1038DB7` |
    // | Dynamic power-down start     | Read/Write | `0B68331C-B628-4D81-BBDB-47B79EA2430E` |
    
    static private let kUUIDCharacteristicADCAverages = "7ADE19EA-2202-48E1-AFFB-4D8504024C37"
    static private let kUUIDCharacteristicDecimationFactor = "4D5A0E9C-0164-4D65-8F2D-86741B820EEF"
    static private let kUUIDCharacteristicDynamicPowerDownEnd = "BC276997-792F-4391-9371-78F1C1038DB7"
    static private let kUUIDCharacteristicDynamicPowerDownStart = "0B68331C-B628-4D81-BBDB-47B79EA2430E"

    static let ADCAveragesCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicADCAverages)
    static let decimationFactorCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicDecimationFactor)
    static let dynamicPowerDownEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicDynamicPowerDownEnd)
    static let dynamicPowerDownStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicDynamicPowerDownStart)
    
    // | Characteristic               | Access     | UUID                                   |
    // |------------------------------|------------|----------------------------------------|
    // | LED1 ADC conversion end      | Read/Write | `C455472B-4231-4EF7-A3BD-A1AE2676F9D2` |
    // | LED1 ADC conversion start    | Read/Write | `ED9B9EE3-AAFE-4034-8C07-1D7F495288B1` |
    // | LED1 ADC reset end           | Read/Write | `7049E8C6-A0CE-4380-8186-1B7CD34179ED` |
    // | LED1 ADC reset start         | Read/Write | `C8B42A6D-ECFC-40E8-8E3C-F5876EE749A3` |
    // | LED1 lighting end            | Read/Write | `9C678B37-F3AA-4B8C-AFD5-10B4694E49C7` |
    // | LED1 lighting start          | Read/Write | `F02C15DF-14F1-4872-BE99-33EE64F0E0B3` |
    // | LED1 offset current          | Read/Write | `C5C6B835-56A6-4FC5-81BF-7512595DF3BD` |
    // | LED1 current                 | Read/Write | `A20B7943-5E1D-4053-8C4E-CD44463F460D` |
    // | LED1 sample end              | Read/Write | `F60A8B03-FAB1-433D-9D9E-8722DF003329` |
    // | LED1 sample start            | Read/Write | `FB219512-DC81-461A-B558-FE6E310E9333` |
    
    static private let kUUIDCharacteristicLED1ADCConversionEnd = "C455472B-4231-4EF7-A3BD-A1AE2676F9D2"
    static private let kUUIDCharacteristicLED1ADCConversionStart = "ED9B9EE3-AAFE-4034-8C07-1D7F495288B1"
    static private let kUUIDCharacteristicLED1ADCResetEnd = "7049E8C6-A0CE-4380-8186-1B7CD34179ED"
    static private let kUUIDCharacteristicLED1ADCResetStart = "C8B42A6D-ECFC-40E8-8E3C-F5876EE749A3"
    static private let kUUIDCharacteristicLED1LightingEnd = "9C678B37-F3AA-4B8C-AFD5-10B4694E49C7"
    static private let kUUIDCharacteristicLED1LightingStart = "F02C15DF-14F1-4872-BE99-33EE64F0E0B3"
    static private let kUUIDCharacteristicLED1OffsetCurrent = "C5C6B835-56A6-4FC5-81BF-7512595DF3BD"
    static private let kUUIDCharacteristicLED1Current = "A20B7943-5E1D-4053-8C4E-CD44463F460D"
    static private let kUUIDCharacteristicLED1SampleEnd = "F60A8B03-FAB1-433D-9D9E-8722DF003329"
    static private let kUUIDCharacteristicLED1SampleStart = "FB219512-DC81-461A-B558-FE6E310E9333"

    static let led1ADCConversionEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1ADCConversionEnd)
    static let led1ADCConversionStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1ADCConversionStart)
    static let led1ADCResetEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1ADCResetEnd)
    static let led1ADCResetStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1ADCResetStart)
    static let led1LightingEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1LightingEnd)
    static let led1LightingStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1LightingStart)
    static let led1OffsetCurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1OffsetCurrent)
    static let led1CurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1Current)
    static let led1SampleEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1SampleEnd)
    static let led1SampleStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED1SampleStart)
    
    // | Characteristic               | Access     | UUID                                   |
    // |------------------------------|------------|----------------------------------------|
    // | LED2 ADC conversion end      | Read/Write | `40314C89-306E-47F0-AE1F-C5DDD8C0CDDD` |
    // | LED2 ADC conversion start    | Read/Write | `160CC306-3CA6-4BF5-AC0B-85443F3CFC6B` |
    // | LED2 ADC reset end           | Read/Write | `34D6F164-543F-49F4-B0F1-6E68DC4CEE6B` |
    // | LED2 ADC reset start         | Read/Write | `E34424D5-68DA-467F-93FE-BE49F19FAB0E` |
    // | LED2 lighting end            | Read/Write | `B85968BA-FB52-46E8-81A5-0F837BF3D6EB` |
    // | LED2 lighting start          | Read/Write | `F710D5DC-2655-42D6-97AA-7A5FDF0285C8` |
    // | LED2 offset current          | Read/Write | `1F23AD86-30CB-4AC2-AD23-226DA5B2EB0C` |
    // | LED2 current                 | Read/Write | `29CA51A3-B33B-44FD-853C-00FE8827ADC4` |
    // | LED2 sample end              | Read/Write | `F752142C-5BFC-4274-9044-E81D3F2F274A` |
    // | LED2 sample start            | Read/Write | `38644B85-3D2E-4D31-9679-06C9EB6BAC2D` |
    
    static private let kUUIDCharacteristicLED2ADCConversionEnd = "40314C89-306E-47F0-AE1F-C5DDD8C0CDDD"
    static private let kUUIDCharacteristicLED2ADCConversionStart = "160CC306-3CA6-4BF5-AC0B-85443F3CFC6B"
    static private let kUUIDCharacteristicLED2ADCResetEnd = "34D6F164-543F-49F4-B0F1-6E68DC4CEE6B"
    static private let kUUIDCharacteristicLED2ADCResetStart = "E34424D5-68DA-467F-93FE-BE49F19FAB0E"
    static private let kUUIDCharacteristicLED2LightingEnd = "B85968BA-FB52-46E8-81A5-0F837BF3D6EB"
    static private let kUUIDCharacteristicLED2LightingStart = "F710D5DC-2655-42D6-97AA-7A5FDF0285C8"
    static private let kUUIDCharacteristicLED2OffsetCurrent = "1F23AD86-30CB-4AC2-AD23-226DA5B2EB0C"
    static private let kUUIDCharacteristicLED2Current = "29CA51A3-B33B-44FD-853C-00FE8827ADC4"
    static private let kUUIDCharacteristicLED2SampleEnd = "F752142C-5BFC-4274-9044-E81D3F2F274A"
    static private let kUUIDCharacteristicLED2SampleStart = "38644B85-3D2E-4D31-9679-06C9EB6BAC2D"

    static let led2ADCConversionEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2ADCConversionEnd)
    static let led2ADCConversionStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2ADCConversionStart)
    static let led2ADCResetEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2ADCResetEnd)
    static let led2ADCResetStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2ADCResetStart)
    static let led2LightingEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2LightingEnd)
    static let led2LightingStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2LightingStart)
    static let led2OffsetCurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2OffsetCurrent)
    static let led2CurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2Current)
    static let led2SampleEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2SampleEnd)
    static let led2SampleStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED2SampleStart)
    
    // | Characteristic               | Access     | UUID                                   |
    // |------------------------------|------------|----------------------------------------|
    // | LED3 ADC conversion end      | Read/Write | `7C2A9A6F-95EB-45ED-B7E1-BB290F7853ED` |
    // | LED3 ADC conversion start    | Read/Write | `C03D3143-E6B6-49AB-85FC-EEED3A43B530` |
    // | LED3 ADC reset end           | Read/Write | `A7D441AA-C456-4CBF-A0B9-84DBF33934EF` |
    // | LED3 ADC reset start         | Read/Write | `536D72C8-DFF0-4E38-93F7-7F376316EA8D` |
    // | LED3 lighting end            | Read/Write | `5B7F9859-092B-43D4-AC6B-AC9DD4742AB2` |
    // | LED3 lighting start          | Read/Write | `0B098015-110E-487E-AAE9-BEA1ED1F54A0` |
    // | LED3 offset current          | Read/Write | `41AE7B18-F5D7-4475-9E3F-49354F077CED` |
    // | LED3 current                 | Read/Write | `F7535ED9-CB9F-469A-817E-1635DC3B68B0` |
    // | LED3 sample end              | Read/Write | `249782EC-004B-4A3D-9608-5143E69AB294` |
    // | LED3 sample start            | Read/Write | `733C5AED-D3B3-4F65-8898-6EA37DA30F71` |
    
    static private let kUUIDCharacteristicLED3ADCConversionEnd = "7C2A9A6F-95EB-45ED-B7E1-BB290F7853ED"
    static private let kUUIDCharacteristicLED3ADCConversionStart = "C03D3143-E6B6-49AB-85FC-EEED3A43B530"
    static private let kUUIDCharacteristicLED3ADCResetEnd = "A7D441AA-C456-4CBF-A0B9-84DBF33934EF"
    static private let kUUIDCharacteristicLED3ADCResetStart = "536D72C8-DFF0-4E38-93F7-7F376316EA8D"
    static private let kUUIDCharacteristicLED3LightingEnd = "5B7F9859-092B-43D4-AC6B-AC9DD4742AB2"
    static private let kUUIDCharacteristicLED3LightingStart = "0B098015-110E-487E-AAE9-BEA1ED1F54A0"
    static private let kUUIDCharacteristicLED3OffsetCurrent = "41AE7B18-F5D7-4475-9E3F-49354F077CED"
    static private let kUUIDCharacteristicLED3Current = "F7535ED9-CB9F-469A-817E-1635DC3B68B0"
    static private let kUUIDCharacteristicLED3SampleEnd = "249782EC-004B-4A3D-9608-5143E69AB294"
    static private let kUUIDCharacteristicLED3SampleStart = "733C5AED-D3B3-4F65-8898-6EA37DA30F71"

    static let led3ADCConversionEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3ADCConversionEnd)
    static let led3ADCConversionStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3ADCConversionStart)
    static let led3ADCResetEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3ADCResetEnd)
    static let led3ADCResetStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3ADCResetStart)
    static let led3LightingEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3LightingEnd)
    static let led3LightingStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3LightingStart)
    static let led3OffsetCurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3OffsetCurrent)
    static let led3CurrentCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3Current)
    static let led3SampleEndCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3SampleEnd)
    static let led3SampleStartCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicLED3SampleStart)
    
    // | Characteristic               | Access     | UUID                                   |
    // |------------------------------|------------|----------------------------------------|
    // | TIA capacitor 1              | Read/Write | `08B3B8E9-D3AD-48EB-B93B-AF4D3695F05C` |
    // | TIA capacitor 2              | Read/Write | `740669DF-57D3-4147-87B4-DC302512F20A` |
    // | TIA resistor 1               | Read/Write | `81831E3A-917E-4252-9C16-42BA8FF3F47A` |
    // | TIA resistor 2               | Read/Write | `A3F694D1-C378-4124-BF56-468DFAFF14E6` |
    // | Total window length          | Read/Write | `B904BD23-6082-4507-8BD2-7333EF6A2726` |
    
    static private let kUUIDCharacteristicTIACapacitor1 = "08B3B8E9-D3AD-48EB-B93B-AF4D3695F05C"
    static private let kUUIDCharacteristicTIACapacitor2 = "740669DF-57D3-4147-87B4-DC302512F20A"
    static private let kUUIDCharacteristicTIAResistor1 = "81831E3A-917E-4252-9C16-42BA8FF3F47A"
    static private let kUUIDCharacteristicTIAResistor2 = "A3F694D1-C378-4124-BF56-468DFAFF14E6"
    static private let kUUIDCharacteristicTotalWindowLength = "B904BD23-6082-4507-8BD2-7333EF6A2726"

    static let tiaCapacitor1CharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicTIACapacitor1)
    static let tiaCapacitor2CharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicTIACapacitor2)
    static let tiaResistor1CharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicTIAResistor1)
    static let tiaResistor2CharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicTIAResistor2)
    static let totalWindowLengthCharacteristicIdentifier = CBUUID(string: kUUIDCharacteristicTotalWindowLength)
}
