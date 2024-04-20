(defun switch-profile (gas-throttle brake-throttle duration)
  (let ((start-time (get-time))
        (current-profile 1)) ; Start with profile 1
    (loop
      (when (>= (- (get-time) start-time) duration)
        (setf (get-value pps) current-profile) ; Switch to the current profile
        (return))
      (when (and (>= (get-analog adc, gas-throttle) 0.9) ; Toggle if ADC voltage is above 0.9V, change if needed.
                 (>= (get-analog adc, brake-throttle) 0.9)) ; Same as above
        (setf current-profile (if (= current-profile 1) 2 1))) ; Toggle between profile 1 and 2
      (wait 100))))

(switch-profile 0 1 3000) ; Assuming ADC0 is gas throttle and ADC1 is brake throttle, change if needed.
