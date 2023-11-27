
import './application'

export function startStimulusApp() {
  Turbo.start()
}

// This file is responsible for starting the Stimulus app after controllers have been eager-loaded

import { application } from './application'

export function startStimulusApp() {
  application.start()
}

