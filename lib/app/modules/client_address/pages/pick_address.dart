import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pscomidas/app/global/models/entities/delivery_at.dart';
import 'package:pscomidas/app/global/widgets/shimmer_loading/shimmer_loading.dart';
import 'package:pscomidas/app/modules/client_address/widgets/address_list_tile.dart';
import 'package:pscomidas/app/modules/home/schemas.dart';
import 'package:pscomidas/app/modules/register_client/widgets/custom_submit.dart';
import 'package:pscomidas/app/modules/register_client/widgets/custom_text_field.dart';

import '../client_address_store.dart';

class PickAddress extends StatefulWidget {
  const PickAddress({Key? key, this.updateAddress}) : super(key: key);
  final DeliveryAt? updateAddress;
  @override
  _PickAddressState createState() => _PickAddressState();
}

class _PickAddressState extends State<PickAddress> {
  final ClientAddressStore store = Modular.get();

  @override
  void initState() {
    if (widget.updateAddress != null) {
      store.isEditing = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    store.disposePick();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => store.jump(1),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: secondaryCollor,
                ),
              ),
              //const SizedBox(width: 50.0),
              const Text(
                'Busque o endereço pelo CEP',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          CustomTextField(
            controller: store.cepController,
            title: 'CEP',
            hint: '00000-000',
            formaters: [
              MaskTextInputFormatter(
                mask: '#####-###',
                filter: {"#": RegExp(r'[0-9]')},
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'CEP Inválido';
              }
            },
          ),
          Observer(builder: (_) {
            if (store.tempAddress.body == null) {
              return WarningListTile(onTap: () => store.jump(1));
            }

            if (store.tempAddress.isLoading) {
              return const ShimmerLoading(
                child: AddressListTile(),
              );
            }

            if (store.tempAddress.hasError) {
              return WarningListTile(
                errorMessage: store.tempAddress.message,
                onTap: () => store.jump(1),
                icon: Icons.error_outline_rounded,
              );
            }

            return AddressListTile(address: store.tempAddress.body);
          }),
          CustomSubmit(
            label: 'Buscar CEP',
            onPressed: () async => store.findCEP(),
          ),
        ],
      ),
    );
  }
}

class WarningListTile extends StatelessWidget {
  const WarningListTile({
    Key? key,
    this.errorMessage,
    this.hasError = false,
    this.icon = Icons.location_on_outlined,
    this.onTap,
  }) : super(key: key);

  final String? errorMessage;
  final bool hasError;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: hasError ? secondaryCollor : Colors.transparent,
      ),
      child: ListTile(
        trailing: Icon(
          icon,
          color: hasError ? Colors.white : tertiaryCollor,
        ),
        title: const Text('Seu endereço endereço aparece por aqui'),
        subtitle: Text(errorMessage ?? ''),
        onTap: onTap,
      ),
    );
  }
}
