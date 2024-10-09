import 'package:equatable/equatable.dart';

abstract class InvoiceDownload extends Equatable {
  const InvoiceDownload();
}

class InvoiceDownloadEvent extends InvoiceDownload {
  final String url;
  const InvoiceDownloadEvent(this.url);

  @override
  List<Object?> get props => [];
}

// class InvoiceDownload extends InvoiceDownloadEvent {
//   final String url;
//   const InvoiceDownload(this.url);
//   @override
//   List<Object?> get props => [url];
// }
