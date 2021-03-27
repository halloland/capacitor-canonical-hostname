import { WebPlugin } from '@capacitor/core';
import { CanonicalHostnamePlugin, CanonicalHostnameOptions } from './definitions';

export class CanonicalHostnameWeb extends WebPlugin implements CanonicalHostnamePlugin {
  constructor() {
    super({
      name: 'CanonicalHostname',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
  
  async getCanonicalHostname(options: CanonicalHostnameOptions): Promise<{hostname: string}> {
	  return null;
  }

}

const CanonicalHostname = new CanonicalHostnameWeb();

export { CanonicalHostname };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(CanonicalHostname);
