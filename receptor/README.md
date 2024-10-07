# Módulos utilizados para el receptor

A continuación se presenta el diagrama de bloques del hardware del proyecto.

![Diagrama del sistema](./img/bloques_rxhw.png "Diagrama del hardware del módulo receptor")

En este repositorio se encuentran los código RTL  de la implementación realizada, el módulo principal
es *dsp.v*, en este mismo se instancia todos los módulos utilizados. La organización de la
carpeta **receptor** se ilustra a continuación.

```
    .
    ├── constraint
    │   └── ports.xdc
    ├── archivos
    │   ├── filter_core
    |   │   ├── files
    |   |   └── fir_LPF.ipynb
    │   ├── bram_core
    |   |   ├── bram_conect.v
    |   |   └── enable_slicer.v
    │   └── dsp_top
    |       ├── ip
    |       |   ├── dds_compiler_0.xcix
    |       |   ├── filter_cic.xcix
    |       |   ├── filter_fir.xcix
    |       |   ├── fir_compiler_0.xcix
    |       |   ├── IP_bram_controller_0.xcix
    |       |   └── mult_gen_cos.xcix   
    |       ├── dsp_top.v
    |       ├── bram_conect.v
    |       ├── enable_slicer.v
    |       └── mixed.v
    |
    └── img
    ```