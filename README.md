# Predictive models for paediatric OSA using pulse oximetry

**NOT FOR CLINCAL USE**. For demonstration purposes only. Clinical use is supported through [Visi-Download 2](https://stowood.com/product/visi-download/) in an upcoming release (build date and version TBD).

Demonstration code uses pulse oximetry (SpO₂ and pulse rate) data sampled at 0.5Hz. Data sampled above 0.5Hz must be resampled using the [resample](https://au.mathworks.com/help/signal/ref/resample.html) function in MATLAB. Models are trained and evaluated on pulse oximetry recordings of children aged 2-18 years, and so performance may vary in children aged <2 years, or in adults. Training data were acquired using Masimo Radical-7 pulse oximeters and so performance cannot be guaranteed on other pulse oximeter brands. Analysis of data recorded using consumer-grade pulse oximeters is not recommended.

Please cite: _article forthcoming_
