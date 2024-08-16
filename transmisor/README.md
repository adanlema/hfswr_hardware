# Módulos utilizados para el transmisor

/**
 * GENERAL DESCRIPTION:
 *
 *   PHASE  ------------------------------------|       /-------\
 *                    /--------------\          |-----> |       |
 *   START. --------> |              |                  |  OSC  |
 *   PRT -----------> | SINCRONISMO  | ---------------> |       |
 *   PERIOD --------> |              |                  \-------|
 *                    \-------------/                       |
 *                          |                               |
 *                          |                               |       /--------\
 *                          |--->  /--------\               |----> |         |
 *   CODIGO -------------------->  |        |                      |  MIXED  |  ------> DAC DATOS
 *   NUM_DIG ------------------->  |  CODE  |  ------------------> |         |  
 *   t_b ----------------------->  |        |                      \--------/
 *                                 \-------/
 *
 * Diagrama de bloques del Transmisor del Radar de Onda Superficial
 * 
 */