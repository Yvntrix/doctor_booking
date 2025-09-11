import 'package:doctor_booking/data/tables/doctors/doctor_table.dart';
import 'package:doctor_booking/domain/entities/doctor_entity.dart';

extension DoctorTableMapper on DoctorTable {
  Doctor toDomain() => Doctor(
    id: id,
    name: name,
    specialty: specialty,
    availability: availability.map((a) => a.toDomain()).toList(),
  );
}

extension DoctorAvailabilityTableMapper on DoctorAvailabilityTable {
  DoctorAvailability toDomain() => DoctorAvailability(
    day: day,
    slots: slots.map((s) => s.toDomain()).toList(),
  );
}

extension DoctorSlotTableMapper on DoctorSlotTable {
  DoctorSlot toDomain() => DoctorSlot(
    start: start,
    end: end,
  );
}
