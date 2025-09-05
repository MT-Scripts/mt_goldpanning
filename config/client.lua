return {
    ---@type { min: number, max: number } Time the progress bar takes in milliseconds
    progress = {
        min = 2500,
        max = 5000
    },

    ---@type { enabled: boolean, difficulty: string[], keys: string[] } Minigame settings
    minigame = {
        enabled = true,
        difficulty = { 'easy', 'easy', 'easy' },
        keys = { '1', '2', '3', '4' }
    },

    ---@type { anim: { dict: string, clip: string, flag: number, bone: number }, props: string[] } Animation settings
    animation = {
        anim = {
            dict = 'amb@world_human_bum_wash@male@high@idle_a',
            clip = 'idle_a',
            flag = 11,
            bone = 60309
        },
        props = {
            'bzzz_prop_mine_bowl_gold_a',
            'bzzz_prop_mine_bowl_gold_b'
        }
    }
}
