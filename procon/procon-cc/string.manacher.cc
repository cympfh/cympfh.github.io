vector<int> manacher(string&s) {
    const int n = s.size();
    vector<int> r(2 * n - 1);
    for (int i = 0, j = 0; i < 2 * n - 1;) {
        while (i >= j and i + j + 1 < 2 * n and s[(i - j) / 2] == s[(i + j + 1) / 2]) {
            ++j;
        }
        r[i] = j;
        int k;
        for (k = 1; i >= k and i + k < 2 * n - 1 and r[i] >= k and r[i - k] != r[i] - k; ++k) {
            r[i + k] = min(r[i - k], r[i] - k);
        }
        i += k;
        j = max(j - k, 0);
    }
    return r;
}
