/* ========================================================================
 * iir_filters.h
 *
 * Functions inspired in IIR_filters_fourth_order.c (v 1.00) by Richard Sikora
 * from Texas Instruments.
 * 
 * Version: 002
 * Date:    2018/04/09
 * Author:  Rodrigo Gonzalez <rodralez@frm.utn.edu.ar>
 * URL:     https://github.com/rodralez/control
 *
 * ===================================================================== */
 
#ifndef IIR_FILTERS_H
#define IIR_FILTERS_H

float second_order_IIR_direct_form_I_float  (const float input, const float * coeff, const float * gain);
float second_order_IIR_direct_form_II_float (const float input, const float * coeff, const float * gain);

void iir_filter_I_float (const float * input, const float * coeff,  const float * gain, const unsigned int N, float * output);
void iir_filter_II_float(const float * input, const float * coeff,  const float * gain, const unsigned int N, float * output);

signed int second_order_IIR_direct_form_I_fixed(const signed int * coefficients, signed int input);
signed int second_order_IIR_direct_form_II_fixed ( const signed int * coefficients, signed int input);

#endif
