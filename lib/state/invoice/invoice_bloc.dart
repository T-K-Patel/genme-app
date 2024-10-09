import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genme_app/state/invoice/invoice_event.dart';
import 'package:genme_app/state/invoice/invoice_provider.dart';
import 'package:genme_app/state/invoice/invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceDownload, InvoiceState> {
  final InvoiceProvider provider;

  InvoiceBloc(this.provider) : super(InvoiceInitialState()) {
    on<InvoiceDownloadEvent>((event, emit) async {
      final String url = event.url;
      emit(InvoiceLoadingState());
      print("invoicedownloadevent");
      try {
        print("insidetry");
        // await provider.downloadInvoice(url);
        print("afterawait");
        // emit(InvoiceInitialState());
      } catch (e) {
        print("incatch$e");
        // emit(InvoiceInitialState());
      }
    });
  }
}
