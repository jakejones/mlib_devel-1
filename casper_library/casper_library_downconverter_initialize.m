function casper_library_downconverter_initialize()

	warning off Simulink:Engine:MdlFileShadowing;
	close_system('casper_library_downconverter', 0);
	mdl = new_system('casper_library_downconverter', 'Library');
	blk = get(mdl,'Name');
	% Set the EnableLBRepository property to on
	try
	  set_param(mdl, 'EnableLBRepository', 'on');
	catch
	  % ignore
	end
	warning on Simulink:Engine:MdlFileShadowing;

	add_block('built-in/SubSystem', [blk,'/mixer']);
	mixer_gen([blk,'/mixer']);
	set_param([blk,'/mixer'], ...
		'freq_div', sprintf('2'), ...
		'freq', sprintf('2'), ...
		'nstreams', sprintf('0'), ...
		'n_bits', sprintf('4'), ...
		'bram_latency', sprintf('2'), ...
		'mult_latency', sprintf('4'), ...
		'Position', sprintf('[15 30 80 120]'), ...
		'Tag', sprintf('casper:mixer'));

	add_block('built-in/SubSystem', [blk,'/sincos']);
	sincos_gen([blk,'/sincos']);
	set_param([blk,'/sincos'], ...
		'func', sprintf('sine and cosine'), ...
		'neg_sin', sprintf('off'), ...
		'neg_cos', sprintf('off'), ...
		'symmetric', sprintf('on'), ...
		'handle_sync', sprintf('off'), ...
		'depth_bits', sprintf('0'), ...
		'bit_width', sprintf('16'), ...
		'bram_latency', sprintf('2'), ...
		'Position', sprintf('[102 26 157 64]'), ...
		'Tag', sprintf('casper:sincos'));

	add_block('built-in/SubSystem', [blk,'/feedback_osc']);
	feedback_osc_gen([blk,'/feedback_osc']);
	set_param([blk,'/feedback_osc'], ...
		'n_bits', sprintf('0'), ...
		'n_bits_rotation', sprintf('25'), ...
		'phase_initial', sprintf('0'), ...
		'phase_step_bits', sprintf('8'), ...
		'phase_steps_bits', sprintf('8'), ...
		'ref_values_bits', sprintf('1'), ...
		'bram_latency', sprintf('2'), ...
		'mult_latency', sprintf('2'), ...
		'add_latency', sprintf('1'), ...
		'conv_latency', sprintf('2'), ...
		'bram', sprintf('Distributed memory'), ...
		'quantization', sprintf('Round  (unbiased: Even Values)'), ...
		'Position', sprintf('[105 101 145 139]'), ...
		'Tag', sprintf('casper:feedback_osc'));

	add_block('built-in/SubSystem', [blk,'/cosin']);
	cosin_gen([blk,'/cosin']);
	set_param([blk,'/cosin'], ...
		'output0', sprintf('sin'), ...
		'output1', sprintf('cos'), ...
		'indep_theta', sprintf('off'), ...
		'phase', sprintf('0'), ...
		'fraction', sprintf('0'), ...
		'table_bits', sprintf('0'), ...
		'n_bits', sprintf('18'), ...
		'bin_pt', sprintf('17'), ...
		'floating_point', sprintf('off'), ...
		'float_type', sprintf('single'), ...
		'exp_width', sprintf('8'), ...
		'frac_width', sprintf('24'), ...
		'store', sprintf('0'), ...
		'pack', sprintf('off'), ...
		'bram', sprintf('BRAM'), ...
		'misc', sprintf('off'), ...
		'bram_latency', sprintf('1'), ...
		'add_latency', sprintf('1'), ...
		'mux_latency', sprintf('1'), ...
		'neg_latency', sprintf('1'), ...
		'conv_latency', sprintf('1'), ...
		'Position', sprintf('[175 26 230 64]'), ...
		'Tag', sprintf('casper:cosin'));

	add_block('built-in/SubSystem', [blk,'/dec_fir']);
	dec_fir_gen([blk,'/dec_fir']);
	set_param([blk,'/dec_fir'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'n_bits', sprintf('8'), ...
		'n_bits_bp', sprintf('7'), ...
		'quantization', sprintf('Round  (unbiased: +/- Inf)'), ...
		'add_latency', sprintf('1'), ...
		'mult_latency', sprintf('2'), ...
		'conv_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'absorb_adders', sprintf('on'), ...
		'adder_imp', sprintf('DSP48'), ...
		'lshift', sprintf('1'), ...
		'Position', sprintf('[15 215 80 308]'), ...
		'Tag', sprintf('casper:dec_fir'));

	add_block('built-in/SubSystem', [blk,'/lo_osc']);
	lo_osc_gen([blk,'/lo_osc']);
	set_param([blk,'/lo_osc'], ...
		'n_bits', sprintf('0'), ...
		'counter_step', sprintf('3'), ...
		'counter_start', sprintf('4'), ...
		'counter_width', sprintf('4'), ...
		'csp_latency', sprintf('2'), ...
		'Position', sprintf('[248 26 288 81]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/fir_tap']);
	fir_tap_gen([blk,'/fir_tap']);
	set_param([blk,'/fir_tap'], ...
		'factor', sprintf('1'), ...
		'csp_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('0'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'Position', sprintf('[100 215 150 282]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/fir_dbl_tap']);
	fir_dbl_tap_gen([blk,'/fir_dbl_tap']);
	set_param([blk,'/fir_dbl_tap'], ...
		'factor', sprintf('0.073384000000000004781952611665474'), ...
		'add_latency', sprintf('1'), ...
		'mult_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('0'), ...
		'coeff_bin_pt', sprintf('17'), ...
		'Position', sprintf('[172 215 222 282]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/lo_const']);
	lo_const_gen([blk,'/lo_const']);
	set_param([blk,'/lo_const'], ...
		'n_bits', sprintf('0'), ...
		'phase', sprintf('0'), ...
		'Position', sprintf('[306 26 346 81]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/fir_dbl_col']);
	fir_dbl_col_gen([blk,'/fir_dbl_col']);
	set_param([blk,'/fir_dbl_col'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'add_latency', sprintf('2'), ...
		'mult_latency', sprintf('3'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'first_stage_hdl', sprintf('off'), ...
		'adder_imp', sprintf('Fabric'), ...
		'Position', sprintf('[244 215 279 330]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/dds']);
	dds_gen([blk,'/dds']);
	set_param([blk,'/dds'], ...
		'freq_div', sprintf('4'), ...
		'freq', sprintf('1'), ...
		'num_lo', sprintf('0'), ...
		'n_bits', sprintf('8'), ...
		'csp_latency', sprintf('2'), ...
		'Position', sprintf('[364 25 404 80]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/fir_col']);
	fir_col_gen([blk,'/fir_col']);
	set_param([blk,'/fir_col'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'add_latency', sprintf('2'), ...
		'mult_latency', sprintf('3'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'first_stage_hdl', sprintf('off'), ...
		'adder_imp', sprintf('Fabric'), ...
		'Position', sprintf('[301 215 336 330]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/rcmult']);
	rcmult_gen([blk,'/rcmult']);
	set_param([blk,'/rcmult'], ...
		'mult_latency', sprintf('0'), ...
		'Position', sprintf('[422 26 462 81]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/dec_fir_async']);
	dec_fir_async_gen([blk,'/dec_fir_async']);
	set_param([blk,'/dec_fir_async'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'output_width', sprintf('8'), ...
		'output_bp', sprintf('7'), ...
		'quantization', sprintf('Round  (unbiased: +/- Inf)'), ...
		'add_latency', sprintf('1'), ...
		'mult_latency', sprintf('2'), ...
		'conv_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'lshift', sprintf('1'), ...
		'absorb_adders', sprintf('on'), ...
		'adder_imp', sprintf('DSP48'), ...
		'async', sprintf('off'), ...
		'bus_input', sprintf('off'), ...
		'input_width', sprintf('0'), ...
		'input_bp', sprintf('0'), ...
		'input_type', sprintf('Signed'), ...
		'Position', sprintf('[15 405 80 498]'), ...
		'Tag', sprintf('casper:dec_fir_async'));

	add_block('built-in/SubSystem', [blk,'/fir_tap_async']);
	fir_tap_async_gen([blk,'/fir_tap_async']);
	set_param([blk,'/fir_tap_async'], ...
		'factor', sprintf('1'), ...
		'add_latency', sprintf('1'), ...
		'mult_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('0'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'async', sprintf('off'), ...
		'dbl', sprintf('off'), ...
		'Position', sprintf('[125 404 175 476]'), ...
		'Tag', sprintf(''));

	add_block('built-in/SubSystem', [blk,'/fir_col_async']);
	fir_col_async_gen([blk,'/fir_col_async']);
	set_param([blk,'/fir_col_async'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'add_latency', sprintf('2'), ...
		'mult_latency', sprintf('3'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'first_stage_hdl', sprintf('off'), ...
		'adder_imp', sprintf('Fabric'), ...
		'async', sprintf('off'), ...
		'bus_input', sprintf('off'), ...
		'input_width', sprintf('16'), ...
		'input_bp', sprintf('0'), ...
		'input_type', sprintf('Signed'), ...
		'dbl', sprintf('off'), ...
		'Position', sprintf('[226 405 261 520]'), ...
		'Tag', sprintf(''));

	set_param(blk, ...
		'Name', sprintf('casper_library_downconverter'), ...
		'LibraryType', sprintf('BlockLibrary'), ...
		'Lock', sprintf('off'), ...
		'PreSaveFcn', sprintf('mdl2m(gcs);'), ...
		'SolverName', sprintf('ode45'), ...
		'SolverMode', sprintf('SingleTasking'), ...
		'StartTime', sprintf('0.0'), ...
		'StopTime', sprintf('10.0'));
	filename = save_system(mdl,[getenv('MLIB_DEVEL_PATH'), '/casper_library/', 'casper_library_downconverter', '.slx']);
	if iscell(filename), filename = filename{1}; end;
	fileattrib(filename, '+w');
end % casper_library_downconverter_initialize

function mixer_gen(blk)

	mixer_mask(blk);
	mixer_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('mixer_init(gcb, ...\n    ''freq_div'', freq_div, ...\n    ''freq'', freq, ...\n    ''nstreams'', nstreams, ...\n    ''n_bits'', n_bits, ...\n    ''bram_latency'', bram_latency, ...\n    ''mult_latency'', mult_latency);\n'));

end % mixer_gen

function mixer_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('mixer'), ...
		'MaskDescription', sprintf('Digitally mixes an input signal (which can be several samples in parallel) with an LO of the indicated frequency (which is some fraction of the native FPGA clock rate).'), ...
		'MaskPromptString', sprintf('Frequency Divisions (M)|Mixing Frequency (? / M*2pi)|Number of Parallel Streams|Bit Width|BRAM Latency|Mult Latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('|||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('freq_div=@1;freq=@2;nstreams=@3;n_bits=@4;bram_latency=@5;mult_latency=@6;'), ...
		'MaskValueString', sprintf('2|2|0|4|2|4'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'Tag', sprintf('casper:mixer'));

end % mixer_mask

function mixer_initialize(blk)

end % mixer_initialize

function sincos_gen(blk)

	sincos_mask(blk);
	sincos_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('sincos_init(gcb, ...\n    ''func'', func, ...\n    ''neg_sin'', neg_sin, ...\n    ''neg_cos'', neg_cos, ...\n    ''symmetric'', symmetric, ...\n    ''handle_sync'', handle_sync, ...\n    ''depth_bits'', depth_bits, ...\n    ''bit_width'', bit_width, ...\n    ''bram_latency'', bram_latency);'));

end % sincos_gen

function sincos_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('sincos'), ...
		'MaskPromptString', sprintf('Function|Negative sine|Negative cosine|Symmetric output|Handle sync|Lookup table depth (2^?)|Output bit width|BRAM latency'), ...
		'MaskStyleString', sprintf('popup(cosine|sine|sine and cosine),checkbox,checkbox,checkbox,checkbox,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('|||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('func=&1;neg_sin=&2;neg_cos=&3;symmetric=&4;handle_sync=&5;depth_bits=@6;bit_width=@7;bram_latency=@8;'), ...
		'MaskValueString', sprintf('sine and cosine|off|off|on|off|0|16|2'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'Tag', sprintf('casper:sincos'));

end % sincos_mask

function sincos_initialize(blk)

end % sincos_initialize

function feedback_osc_gen(blk)

	feedback_osc_mask(blk);
	feedback_osc_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('feedback_osc_init(gcb, ...\n    ''n_bits'', n_bits, ...           \n    ''n_bits_rotation'', n_bits_rotation, ...  \n    ''phase_initial'', phase_initial, ...\n    ''phase_step_bits'', phase_step_bits, ...\n    ''phase_steps_bits'', phase_steps_bits, ...\n    ''ref_values_bits'', ref_values_bits, ...\n    ''bram_latency'', bram_latency, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''conv_latency'', conv_latency, ...\n    ''bram'', bram, ...\n    ''quantization'', quantization);\n'));

end % feedback_osc_gen

function feedback_osc_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('feedback_osc'), ...
		'MaskDescription', sprintf('A complex exponential generated using an initial vector, complex multiplication\nto rotate it, and feedback. A lookup table of reference vectors is used\nto periodically remove accumulated error.'), ...
		'MaskPromptString', sprintf('output bit resolution|rotation vector bit resolution |initial phase ?*(2*pi)|phase step size (2*pi)/2^?|number phase steps 2^?|number calibration locations (2^?)|BRAM latency|multiplier latency|adder latency|convert latency|BRAM implementation|quantization strategy'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,edit,edit,edit,edit,popup(Distributed memory|Block RAM),popup(Truncate|Round  (unbiased: +/- Inf)|Round  (unbiased: Even Values))'), ...
		'MaskTabNameString', sprintf('basic,basic,basic,basic,basic,basic,latency,latency,latency,latency,implementation,implementation'), ...
		'MaskCallbackString', sprintf('|||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;n_bits_rotation=@2;phase_initial=@3;phase_step_bits=@4;phase_steps_bits=@5;ref_values_bits=@6;bram_latency=@7;mult_latency=@8;add_latency=@9;conv_latency=@10;bram=&11;quantization=&12;'), ...
		'MaskValueString', sprintf('0|25|0|8|8|1|2|2|1|2|Distributed memory|Round  (unbiased: Even Values)'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'Tag', sprintf('casper:feedback_osc'));

end % feedback_osc_mask

function feedback_osc_initialize(blk)

end % feedback_osc_initialize

function cosin_gen(blk)

	cosin_mask(blk);
	cosin_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('cosin_init(gcb, ...\n    ''output0'', output0, ...    \n    ''output1'', output1, ...\n    ''indep_theta'', indep_theta, ...\n    ''phase'', phase, ...\n    ''fraction'', fraction, ...\n    ''table_bits'', table_bits, ...  \n    ''n_bits'', n_bits, ...      \n    ''bin_pt'', bin_pt, ...    \n    ''floating_point'', floating_point, ...\n    ''float_type'', float_type, ...\n    ''exp_width'', exp_width, ...\n    ''frac_width'', frac_width, ...         \n    ''bram_latency'', bram_latency, ...\n    ''add_latency'', add_latency, ...\n    ''mux_latency'', mux_latency, ...\n    ''neg_latency'', neg_latency, ...\n    ''conv_latency'', conv_latency, ...\n    ''store'', store, ...\n    ''pack'', pack, ...\n    ''bram'', bram, ...\n    ''misc'', misc);\n'));

end % cosin_gen

function cosin_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('cosin'), ...
		'MaskPromptString', sprintf('first output function|second output function|Independent theta values|initial phase offset (?*(2*pi))|fraction of cycle period to output (1/2^?)|samples in cycle period fraction to output (2^?)|bit width|binary point|floating point|float type|exponent width|fraction width|fraction of cycle period to store (1/2^?)|pack lookup values in same output word|BRAM implementation|Miscellaneous port|bram latency|large adder latency|mux latency|negate latency|convert latency'), ...
		'MaskStyleString', sprintf('popup(sin|cos|-sin|-cos),popup(none|sin|cos|-sin|-cos),checkbox,edit,edit,edit,edit,edit,checkbox,radiobutton(single|custom),edit,edit,edit,checkbox,popup(distributed RAM|BRAM),checkbox,edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||||||onoff = get_param(gcb, ''floating_point'');\nif strcmp(onoff,''on'')\n    enable_fixpt = ''off''\n    set_param_state(gcb, ''float_type'', ''on'')\n    \n    f_type = get_param(gcb, ''float_type'')\n    if strcmp(f_type,''custom'')\n        set_param_state(gcb, ''exp_width'', ''on'')\n        set_param_state(gcb, ''frac_width'', ''on'')\n    else\n        set_param_state(gcb, ''exp_width'', ''off'')\n        set_param_state(gcb, ''frac_width'', ''off'')\n    end\n    \n    \nelse\n    enable_fixpt = ''on''\n    set_param_state(gcb, ''float_type'', ''off'')\n    set_param_state(gcb, ''exp_width'', ''off'')\n    set_param_state(gcb, ''frac_width'', ''off'')\nend\n\nset_param_state(gcb, ''n_bits'', enable_fixpt)\nset_param_state(gcb, ''bin_pt'', enable_fixpt)\n\n\n\n\n|f_type = get_param(gcb, ''float_type'')\nif strcmp(f_type,''custom'')\n    set_param_state(gcb, ''exp_width'', ''on'')\n    set_param_state(gcb, ''frac_width'', ''on'')\nelse\n    set_param_state(gcb, ''exp_width'', ''off'')\n    set_param_state(gcb, ''frac_width'', ''off'')\nend|||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,off,off,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('output0=&1;output1=&2;indep_theta=&3;phase=@4;fraction=@5;table_bits=@6;n_bits=@7;bin_pt=@8;floating_point=@9;float_type=@10;exp_width=@11;frac_width=@12;store=@13;pack=&14;bram=&15;misc=&16;bram_latency=@17;add_latency=@18;mux_latency=@19;neg_latency=@20;conv_latency=@21;'), ...
		'MaskValueString', sprintf('sin|cos|off|0|0|0|18|17|off|single|8|24|0|off|BRAM|off|1|1|1|1|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'MaskDisplay', sprintf('if ~(table_bits == 0),\n        color(''black'');port_label(''output'',1,output0);\n    color(''black'');port_label(''output'',2,output1);\n    color(''black'');disp([''z^{-'',num2str(add_latency+mux_latency+conv_latency+bram_latency+neg_latency+mux_latency),''}''],''texmode'',''on'');color(''black'');port_label(''input'',1,''theta'');\n    if strcmp(misc, ''on''),\n        color(''black'');port_label(''input'',2,''misci'');\n        color(''black'');port_label(''output'',3,''misco'');\n    end\nend'), ...
		'Tag', sprintf('casper:cosin'));

end % cosin_mask

function cosin_initialize(blk)

end % cosin_initialize

function dec_fir_gen(blk)

	dec_fir_mask(blk);
	dec_fir_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('dec_fir_init(gcb, ...\n    ''n_inputs'', n_inputs, ...\n    ''coeff'', coeff, ...\n    ''n_bits'', n_bits, ...\n    ''n_bits_bp'', n_bits_bp, ...\n    ''quantization'', quantization, ...\n    ''add_latency'', add_latency, ...\n    ''mult_latency'', mult_latency, ...\n    ''conv_latency'', conv_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt, ...\n    ''absorb_adders'', absorb_adders, ...\n    ''adder_imp'', adder_imp, ...\n    ''lshift'', lshift);'));

end % dec_fir_gen

function dec_fir_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('dec_fir'), ...
		'MaskDescription', sprintf('FIR filter which can handle multiple time samples in parallel and decimates down to 1 time sample.  If coefficients are symmetric, will automatically fold before multiplying.'), ...
		'MaskPromptString', sprintf('Number of Parallel Streams|Coefficients|Bit Width Out|Bin Pt Out|Quantization Behavior|Add Latency|Mult Latency|Convert latency|Coefficient bit width|Coefficient binary point|Absorb adders into DSP slices|Adder implementation|Post adder-tree shift'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,popup(Truncate|Round  (unbiased: +/- Inf)|Round  (unbiased: Even Values)),edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48),edit'), ...
		'MaskCallbackString', sprintf('||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;n_bits=@3;n_bits_bp=@4;quantization=&5;add_latency=@6;mult_latency=@7;conv_latency=@8;coeff_bit_width=@9;coeff_bin_pt=@10;absorb_adders=&11;adder_imp=&12;lshift=@13;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|8|7|Round  (unbiased: +/- Inf)|1|2|2|25|24|on|DSP48|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'Tag', sprintf('casper:dec_fir'));

end % dec_fir_mask

function dec_fir_initialize(blk)

end % dec_fir_initialize

function lo_osc_gen(blk)

	lo_osc_mask(blk);
	lo_osc_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('lo_osc_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''counter_step'', counter_step, ...\n    ''counter_start'', counter_start, ...\n    ''counter_width'', counter_width, ...\n    ''csp_latency'', csp_latency);'));

end % lo_osc_gen

function lo_osc_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('lo_osc'), ...
		'MaskDescription', sprintf('Generates -sin and cos data using a look-up \ntable. '), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Lo_osc'''')'')'), ...
		'MaskPromptString', sprintf('Output Bitwidth|counter step|counter start value|Counter Bitwidth|Lookup latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;counter_step=@2;counter_start=@3;counter_width=@4;csp_latency=@5;'), ...
		'MaskValueString', sprintf('0|3|4|4|2'), ...
		'BackgroundColor', sprintf('gray'));

end % lo_osc_mask

function lo_osc_initialize(blk)

end % lo_osc_initialize

function fir_tap_gen(blk)

	fir_tap_mask(blk);
	fir_tap_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_tap_init(gcb, ...\n    ''factor'', factor, ...\n    ''csp_latency'', csp_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt);'));

end % fir_tap_gen

function fir_tap_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_tap'), ...
		'MaskDescription', sprintf('Multiplies input data with factor specified.'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_tap'''')'')'), ...
		'MaskPromptString', sprintf('Factor|Mult latency|Coefficient bit width|Coefficient binary point'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('|||'), ...
		'MaskEnableString', sprintf('on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on'), ...
		'MaskVariables', sprintf('factor=@1;csp_latency=@2;coeff_bit_width=@3;coeff_bin_pt=@4;'), ...
		'MaskValueString', sprintf('1|2|0|24'), ...
		'BackgroundColor', sprintf('gray'));

end % fir_tap_mask

function fir_tap_initialize(blk)

end % fir_tap_initialize

function fir_dbl_tap_gen(blk)

	fir_dbl_tap_mask(blk);
	fir_dbl_tap_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_dbl_tap_init(gcb, ...\n    ''factor'', factor, ...\n    ''add_latency'', add_latency, ...\n    ''mult_latency'', mult_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt);'));

end % fir_dbl_tap_gen

function fir_dbl_tap_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_dbl_tap'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_dbl_tap'''')'')'), ...
		'MaskPromptString', sprintf('factor|Add latency|Mult latency|Coefficient bit width|Coefficient binary point '), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('factor=@1;add_latency=@2;mult_latency=@3;coeff_bit_width=@4;coeff_bin_pt=@5;'), ...
		'MaskValueString', sprintf('0.073384000000000004781952611665474|1|2|0|17'), ...
		'BackgroundColor', sprintf('gray'));

end % fir_dbl_tap_mask

function fir_dbl_tap_initialize(blk)

end % fir_dbl_tap_initialize

function lo_const_gen(blk)

	lo_const_mask(blk);
	lo_const_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('lo_const_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''phase'', phase);'));

end % lo_const_gen

function lo_const_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('lo_const'), ...
		'MaskDescription', sprintf('Generates a complex constant associated with the \nphase supplied as a parameter.'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Lo_const'''')'')'), ...
		'MaskPromptString', sprintf('Output Bitwidth|Phase (0 to 2*pi)'), ...
		'MaskStyleString', sprintf('edit,edit'), ...
		'MaskCallbackString', sprintf('|'), ...
		'MaskEnableString', sprintf('on,on'), ...
		'MaskVisibilityString', sprintf('on,on'), ...
		'MaskToolTipString', sprintf('on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;phase=@2;'), ...
		'MaskValueString', sprintf('0|0'), ...
		'BackgroundColor', sprintf('gray'));

end % lo_const_mask

function lo_const_initialize(blk)

end % lo_const_initialize

function fir_dbl_col_gen(blk)

	fir_dbl_col_mask(blk);
	fir_dbl_col_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_dbl_col_init(gcb, ...\n    ''n_inputs'', n_inputs, ...\n    ''coeff'', coeff, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt,  ...\n    ''first_stage_hdl'', first_stage_hdl, ...\n    ''adder_imp'', adder_imp);'));

end % fir_dbl_col_gen

function fir_dbl_col_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_dbl_col'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_dbl_col'''')'')'), ...
		'MaskPromptString', sprintf('Inputs|Coefficients|Add latency|Mult Latency|Coefficient bit width|Coefficient binary point|Implement first stage of adder trees on output as behavioural HDL|Adder implementation'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48)'), ...
		'MaskCallbackString', sprintf('|||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;add_latency=@3;mult_latency=@4;coeff_bit_width=@5;coeff_bin_pt=@6;first_stage_hdl=&7;adder_imp=&8;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|2|3|25|24|off|Fabric'), ...
		'BackgroundColor', sprintf('gray'));

end % fir_dbl_col_mask

function fir_dbl_col_initialize(blk)

end % fir_dbl_col_initialize

function dds_gen(blk)

	dds_mask(blk);
	dds_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('dds_init(gcb, ...\n    ''freq_div'', freq_div, ...\n    ''freq'', freq, ...\n    ''num_lo'', num_lo, ...\n    ''n_bits'', n_bits, ...\n    ''csp_latency'', csp_latency);'));

end % dds_gen

function dds_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('dds'), ...
		'MaskDescription', sprintf('Generates P channels of sin and cos data for mixing\nwith input data in a DDC. To generate frequency \nN/M(Fc x P) (where Fc is the clock rate) \nM = "Frequency Divisions", N = "Frequency",\nParallel LOs = P'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Dds'''')'')'), ...
		'MaskPromptString', sprintf('Frequency divisions (M)|Frequency (? / M*2pi)|Parallel LOs|Bit Width|Latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('freq_div=@1;freq=@2;num_lo=@3;n_bits=@4;csp_latency=@5;'), ...
		'MaskValueString', sprintf('4|1|0|8|2'), ...
		'BackgroundColor', sprintf('gray'));

end % dds_mask

function dds_initialize(blk)

end % dds_initialize

function fir_col_gen(blk)

	fir_col_mask(blk);
	fir_col_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_col_init(gcb, ...\n    ''n_inputs'', n_inputs,...\n    ''coeff'', coeff, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt, ...\n    ''first_stage_hdl'', first_stage_hdl, ...\n    ''adder_imp'', adder_imp);'));

end % fir_col_gen

function fir_col_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_col'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_col'''')'')'), ...
		'MaskPromptString', sprintf('Inputs|Coefficients|Add latency|Mult Latency|Coefficient bit width|Coefficient binary point|Implement first stage of adder trees on output as behavioural HDL|Adder implementation'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48)'), ...
		'MaskCallbackString', sprintf('|||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;add_latency=@3;mult_latency=@4;coeff_bit_width=@5;coeff_bin_pt=@6;first_stage_hdl=&7;adder_imp=&8;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|2|3|25|24|off|Fabric'), ...
		'BackgroundColor', sprintf('gray'));

end % fir_col_mask

function fir_col_initialize(blk)

end % fir_col_initialize

function rcmult_gen(blk)

	rcmult_mask(blk);
	rcmult_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('rcmult_init(gcb, ...\n    ''mult_latency'', mult_latency);'));

end % rcmult_gen

function rcmult_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('rcmult'), ...
		'MaskDescription', sprintf('Multiplies input data with cos and sin inputs and\noutputs results on real and imag ports \nrespectively. '), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Rcmult'''')'')'), ...
		'MaskPromptString', sprintf('Multiplier latency'), ...
		'MaskStyleString', sprintf('edit'), ...
		'MaskEnableString', sprintf('on'), ...
		'MaskVisibilityString', sprintf('on'), ...
		'MaskToolTipString', sprintf('on'), ...
		'MaskVariables', sprintf('mult_latency=@1;'), ...
		'MaskValueString', sprintf('0'), ...
		'BackgroundColor', sprintf('gray'));

end % rcmult_mask

function rcmult_initialize(blk)

end % rcmult_initialize

function dec_fir_async_gen(blk)

	dec_fir_async_mask(blk);
	dec_fir_async_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('dec_fir_async_init(gcb);'));

end % dec_fir_async_gen

function dec_fir_async_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('dec_fir_async'), ...
		'MaskDescription', sprintf('FIR filter which can handle multiple time samples in parallel and decimates down to 1 time sample.  If coefficients are symmetric, will automatically fold before multiplying.'), ...
		'MaskPromptString', sprintf('Number of Parallel Streams|Coefficients|Output bitwidth|Output binary point|Quantization Behavior|Add Latency|Mult Latency|Convert latency|Coefficient bitwidth|Coefficient binary point|Post adder-tree shift|Absorb adders into DSP slices|Adder implementation|Asynchronous ops|Bus input|Input bitwidth|Input binary point|Input datatype'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,popup(Truncate|Round  (unbiased: +/- Inf)|Round  (unbiased: Even Values)),edit,edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48),checkbox,checkbox,edit,edit,popup(Signed|Unsigned)'), ...
		'MaskCallbackString', sprintf('||||||||||||||onoff = get_param(gcb, ''bus_input'');\nset_param_state(gcb, ''input_width'', onoff)\nset_param_state(gcb, ''input_bp'', onoff)\nset_param_state(gcb, ''input_type'', onoff)|||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,off,off,off'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;output_width=@3;output_bp=@4;quantization=&5;add_latency=@6;mult_latency=@7;conv_latency=@8;coeff_bit_width=@9;coeff_bin_pt=@10;lshift=@11;absorb_adders=&12;adder_imp=&13;async=&14;bus_input=&15;input_width=@16;input_bp=@17;input_type=&18;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|8|7|Round  (unbiased: +/- Inf)|1|2|2|25|24|1|on|DSP48|off|off|0|0|Signed'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'Tag', sprintf('casper:dec_fir_async'));

end % dec_fir_async_mask

function dec_fir_async_initialize(blk)

end % dec_fir_async_initialize

function fir_tap_async_gen(blk)

	fir_tap_async_mask(blk);
	fir_tap_async_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_tap_async_init(gcb);'));

end % fir_tap_async_gen

function fir_tap_async_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_tap_async'), ...
		'MaskDescription', sprintf('Multiplies input data with factor specified.'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_tap'''')'')'), ...
		'MaskPromptString', sprintf('Factor|Add latency|Mult latency|Coefficient bit width|Coefficient binary point|Asynchronous ops|Double tap'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,checkbox,checkbox'), ...
		'MaskCallbackString', sprintf('||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('factor=@1;add_latency=@2;mult_latency=@3;coeff_bit_width=@4;coeff_bin_pt=@5;async=&6;dbl=&7;'), ...
		'MaskValueString', sprintf('1|1|2|0|24|off|off'), ...
		'BackgroundColor', sprintf('gray'));

end % fir_tap_async_mask

function fir_tap_async_initialize(blk)

end % fir_tap_async_initialize

function fir_col_async_gen(blk)

	fir_col_async_mask(blk);
	fir_col_async_initialize(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_col_async_init(gcb);'));

end % fir_col_async_gen

function fir_col_async_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_col_async'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_col'''')'')'), ...
		'MaskPromptString', sprintf('Inputs|Coefficients|Add latency|Mult Latency|Coefficient bit width|Coefficient binary point|Implement first stage of adder trees on output as behavioural HDL|Adder implementation|Asynchronous ops|Bus input|Input bitwidth|Input binary point|Input datatype|Double col'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48),checkbox,checkbox,edit,edit,popup(Signed|Unsigned),checkbox'), ...
		'MaskCallbackString', sprintf('|||||||||onoff = get_param(gcb, ''bus_input'');\nset_param_state(gcb, ''input_width'', onoff)\nset_param_state(gcb, ''input_bp'', onoff)\nset_param_state(gcb, ''input_type'', onoff)||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,off,off,off,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;add_latency=@3;mult_latency=@4;coeff_bit_width=@5;coeff_bin_pt=@6;first_stage_hdl=&7;adder_imp=&8;async=&9;bus_input=&10;input_width=@11;input_bp=@12;input_type=&13;dbl=&14;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|2|3|25|24|off|Fabric|off|off|16|0|Signed|off'), ...
		'BackgroundColor', sprintf('gray'));

end % fir_col_async_mask

function fir_col_async_initialize(blk)

end % fir_col_async_initialize

