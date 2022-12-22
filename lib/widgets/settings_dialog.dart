import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings.dart';
// #TODO Test new address and port before accepting

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<Settings>();
    return IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              String? address;
              int? port;
              return StatefulBuilder(
                builder: (BuildContext context, setState) => AlertDialog(
                    title: const Text('Settings'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView(children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Address of the server'),
                              Text(address ?? settings.address)
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AddressDialog(settings.address),
                          ).then((value) => setState(
                                () => address = value,
                              )),
                        ),
                        ListTile(
                          leading: const Icon(Icons.numbers_outlined),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Server port number'),
                              Text('${port ?? settings.port}')
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => showDialog<int>(
                            context: context,
                            builder: (BuildContext context) =>
                                PortDialog(settings.port),
                          ).then((value) => setState(
                                () => port = value,
                              )),
                        )
                      ]),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel', textScaleFactor: 1.2),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                          child: const Text('Save', textScaleFactor: 1.2),
                          onPressed: () {
                            if (address != null) settings.address = address!;
                            if (port != null) settings.port = port!;
                            Navigator.pop(context);
                          })
                    ]),
              );
            }));
  }
}

class AddressDialog extends StatelessWidget {
  const AddressDialog(this.current, {super.key});
  final String current;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: TextFormField(
            initialValue: current,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Server address',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
            ),
            onFieldSubmitted: (value) => Navigator.of(context).pop(value)),
      ),
    );
  }
}

class PortDialog extends StatelessWidget {
  const PortDialog(this.current, {super.key});
  final int current;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: TextFormField(
            initialValue: '$current',
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Server port number',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
            ),
            onFieldSubmitted: (value) =>
                Navigator.of(context).pop(int.tryParse(value))),
      ),
    );
  }
}
