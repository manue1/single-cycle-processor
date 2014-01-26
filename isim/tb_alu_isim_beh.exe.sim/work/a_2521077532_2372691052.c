/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xa0883be4 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//VBOXSVR/Github/picoblaze-processor/tb_alu.vhd";



static void work_a_2521077532_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 5216);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 2608U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3400);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 5216);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 2608U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3400);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_2521077532_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int64 t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    int64 t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(68, ng0);

LAB3:    t1 = (t0 + 5280);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, 0U, 1, 0LL);
    t6 = (2 * 1000LL);
    t7 = (t0 + 5280);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_subsequent_trans_delta(t7, 0U, 1, t6);
    t12 = (10 * 1000LL);
    t13 = (t0 + 5280);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    *((unsigned char *)t17) = (unsigned char)2;
    xsi_driver_subsequent_trans_delta(t13, 0U, 1, t12);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2521077532_2372691052_p_2(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int64 t8;
    char *t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int64 t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int64 t24;
    char *t25;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    int64 t32;
    char *t33;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;

LAB0:    xsi_set_current_line(69, ng0);

LAB3:    t1 = (t0 + 8044);
    t3 = (t0 + 5344);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 5U);
    xsi_driver_first_trans_delta(t3, 0U, 5U, 0LL);
    t8 = (30 * 1000LL);
    t9 = (t0 + 8049);
    t11 = (t0 + 5344);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t9, 5U);
    xsi_driver_subsequent_trans_delta(t11, 0U, 5U, t8);
    t16 = (40 * 1000LL);
    t17 = (t0 + 8054);
    t19 = (t0 + 5344);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t17, 5U);
    xsi_driver_subsequent_trans_delta(t19, 0U, 5U, t16);
    t24 = (70 * 1000LL);
    t25 = (t0 + 8059);
    t27 = (t0 + 5344);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t25, 5U);
    xsi_driver_subsequent_trans_delta(t27, 0U, 5U, t24);
    t32 = (85 * 1000LL);
    t33 = (t0 + 8064);
    t35 = (t0 + 5344);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    memcpy(t39, t33, 5U);
    xsi_driver_subsequent_trans_delta(t35, 0U, 5U, t32);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2521077532_2372691052_p_3(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int64 t8;
    char *t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int64 t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int64 t24;
    char *t25;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    int64 t32;
    char *t33;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;

LAB0:    xsi_set_current_line(70, ng0);

LAB3:    t1 = (t0 + 8069);
    t3 = (t0 + 5408);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 8U);
    xsi_driver_first_trans_delta(t3, 0U, 8U, 0LL);
    t8 = (30 * 1000LL);
    t9 = (t0 + 8077);
    t11 = (t0 + 5408);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t9, 8U);
    xsi_driver_subsequent_trans_delta(t11, 0U, 8U, t8);
    t16 = (40 * 1000LL);
    t17 = (t0 + 8085);
    t19 = (t0 + 5408);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t17, 8U);
    xsi_driver_subsequent_trans_delta(t19, 0U, 8U, t16);
    t24 = (55 * 1000LL);
    t25 = (t0 + 8093);
    t27 = (t0 + 5408);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t25, 8U);
    xsi_driver_subsequent_trans_delta(t27, 0U, 8U, t24);
    t32 = (70 * 1000LL);
    t33 = (t0 + 8101);
    t35 = (t0 + 5408);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    memcpy(t39, t33, 8U);
    xsi_driver_subsequent_trans_delta(t35, 0U, 8U, t32);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2521077532_2372691052_p_4(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int64 t8;
    char *t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int64 t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int64 t24;
    char *t25;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    int64 t32;
    char *t33;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    int64 t40;
    char *t41;
    char *t43;
    char *t44;
    char *t45;
    char *t46;
    char *t47;

LAB0:    xsi_set_current_line(71, ng0);

LAB3:    t1 = (t0 + 8109);
    t3 = (t0 + 5472);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 8U);
    xsi_driver_first_trans_delta(t3, 0U, 8U, 0LL);
    t8 = (15 * 1000LL);
    t9 = (t0 + 8117);
    t11 = (t0 + 5472);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t9, 8U);
    xsi_driver_subsequent_trans_delta(t11, 0U, 8U, t8);
    t16 = (30 * 1000LL);
    t17 = (t0 + 8125);
    t19 = (t0 + 5472);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t17, 8U);
    xsi_driver_subsequent_trans_delta(t19, 0U, 8U, t16);
    t24 = (40 * 1000LL);
    t25 = (t0 + 8133);
    t27 = (t0 + 5472);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t25, 8U);
    xsi_driver_subsequent_trans_delta(t27, 0U, 8U, t24);
    t32 = (70 * 1000LL);
    t33 = (t0 + 8141);
    t35 = (t0 + 5472);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    t38 = (t37 + 56U);
    t39 = *((char **)t38);
    memcpy(t39, t33, 8U);
    xsi_driver_subsequent_trans_delta(t35, 0U, 8U, t32);
    t40 = (85 * 1000LL);
    t41 = (t0 + 8149);
    t43 = (t0 + 5472);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memcpy(t47, t41, 8U);
    xsi_driver_subsequent_trans_delta(t43, 0U, 8U, t40);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2521077532_2372691052_p_5(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int64 t8;
    char *t9;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    int64 t16;
    char *t17;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int64 t24;
    char *t25;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;

LAB0:    xsi_set_current_line(72, ng0);

LAB3:    t1 = (t0 + 8157);
    t3 = (t0 + 5536);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 4U);
    xsi_driver_first_trans_delta(t3, 0U, 4U, 0LL);
    t8 = (40 * 1000LL);
    t9 = (t0 + 8161);
    t11 = (t0 + 5536);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t9, 4U);
    xsi_driver_subsequent_trans_delta(t11, 0U, 4U, t8);
    t16 = (55 * 1000LL);
    t17 = (t0 + 8165);
    t19 = (t0 + 5536);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t17, 4U);
    xsi_driver_subsequent_trans_delta(t19, 0U, 4U, t16);
    t24 = (70 * 1000LL);
    t25 = (t0 + 8169);
    t27 = (t0 + 5536);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t25, 4U);
    xsi_driver_subsequent_trans_delta(t27, 0U, 4U, t24);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2521077532_2372691052_init()
{
	static char *pe[] = {(void *)work_a_2521077532_2372691052_p_0,(void *)work_a_2521077532_2372691052_p_1,(void *)work_a_2521077532_2372691052_p_2,(void *)work_a_2521077532_2372691052_p_3,(void *)work_a_2521077532_2372691052_p_4,(void *)work_a_2521077532_2372691052_p_5};
	xsi_register_didat("work_a_2521077532_2372691052", "isim/tb_alu_isim_beh.exe.sim/work/a_2521077532_2372691052.didat");
	xsi_register_executes(pe);
}
