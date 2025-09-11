// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingTableAdapter extends TypeAdapter<BookingTable> {
  @override
  final typeId = 4;

  @override
  BookingTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookingTable(
      id: fields[0] as String,
      doctorId: fields[1] as String,
      patientName: fields[2] as String,
      date: fields[3] as DateTime,
      reason: fields[4] as String,
      status: fields[5] == null
          ? BookingTableStatus.pending
          : fields[5] as BookingTableStatus,
    );
  }

  @override
  void write(BinaryWriter writer, BookingTable obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorId)
      ..writeByte(2)
      ..write(obj.patientName)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.reason)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BookingTableStatusAdapter extends TypeAdapter<BookingTableStatus> {
  @override
  final typeId = 3;

  @override
  BookingTableStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BookingTableStatus.pending;
      case 1:
        return BookingTableStatus.approved;
      case 2:
        return BookingTableStatus.rejected;
      default:
        return BookingTableStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, BookingTableStatus obj) {
    switch (obj) {
      case BookingTableStatus.pending:
        writer.writeByte(0);
      case BookingTableStatus.approved:
        writer.writeByte(1);
      case BookingTableStatus.rejected:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingTableStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
