// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorTableAdapter extends TypeAdapter<DoctorTable> {
  @override
  final typeId = 0;

  @override
  DoctorTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorTable(
      id: fields[0] as String,
      name: fields[1] as String,
      specialty: fields[2] as String,
      availability: (fields[3] as List).cast<DoctorAvailabilityTable>(),
    );
  }

  @override
  void write(BinaryWriter writer, DoctorTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.specialty)
      ..writeByte(3)
      ..write(obj.availability);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorAvailabilityTableAdapter
    extends TypeAdapter<DoctorAvailabilityTable> {
  @override
  final typeId = 1;

  @override
  DoctorAvailabilityTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorAvailabilityTable(
      day: fields[0] as String,
      slots: (fields[1] as List).cast<DoctorSlotTable>(),
    );
  }

  @override
  void write(BinaryWriter writer, DoctorAvailabilityTable obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.slots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorAvailabilityTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DoctorSlotTableAdapter extends TypeAdapter<DoctorSlotTable> {
  @override
  final typeId = 2;

  @override
  DoctorSlotTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorSlotTable(
      start: fields[0] as String,
      end: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorSlotTable obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorSlotTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
