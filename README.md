# ApexInvocableSetRecordType
Salesforce Invocable Action for Process Builder / Flow to change record type without any shenanigans

This repository contains three simple classes that are invocable actions that can be used in *Process Builder* and Flow, where especially for the first one, it's been a pain to set a record type without resorting to hardcoding recordtype IDs somewhere (either in the process or some custom setting/label, etc.).

Now this small package takes this pain away. Made possible by API48 release which allows Invocable Actions to take generic parameter types.

Do note that neither the Process Builder version nor the Flow version will use a SOQL query to retrieve the record.
