declare module '@capacitor/core' {
  interface PluginRegistry {
    CanonicalHostname: CanonicalHostnamePlugin;
  }
}

export interface CanonicalHostnamePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  getCanonicalHostname(options: CanonicalHostnameOptions): Promise<{hostname: string}>;
}

export interface CanonicalHostnameOptions {
	ip: string;
}