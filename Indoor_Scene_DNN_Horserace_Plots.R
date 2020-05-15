require(gridExtra)
library(dplyr)
library(ggplot2)

df_runtimes <- read.csv('df_runtimes.txt')
`%notin%` <- Negate(`%in%`)
df_runtimes_accel <- df_runtimes %>% filter(Config %notin% c('i7','i9'))
df_runtimes_noac <- df_runtimes %>% filter(Config %in% c('i7','i9'))

prtac <- ggplot(df_runtimes_accel, aes(x=Epoch,y=Time,color=Architecture, shape=Config)) + 
  geom_jitter(size=2,width=0,height=0.5) +
  ggtitle('Runtime in Seconds for First Ten Epochs: Accelerated')

prtnac <- ggplot(df_runtimes_noac, aes(x=Epoch,y=Time,color=Architecture, shape=Config)) + 
  geom_jitter(size=2,width=0,height=0.5) +
  ggtitle('Runtime in Seconds for First Ten Epochs: Not Accelerated')

grid.arrange(prtac, prtnac, ncol=2)
runtimes_plot <- arrangeGrob(prtac, prtnac, ncol=2)
ggsave('runtimesplot.png',runtimes_plot)

pspmsac <- ggplot(df_runtimes_accel, aes(x=Epoch,y=msPerStep,color=Architecture, shape=Config)) + 
  geom_jitter(size=2,width=0,height=0.5) +
  ggtitle('Milliseconds Per Step for First Ten Epochs: Accelerated') +
  ylab('Milliseconds Per Step')

pspmsnac <- ggplot(df_runtimes_noac, aes(x=Epoch,y=msPerStep,color=Architecture, shape=Config)) + 
  geom_jitter(size=2) + #,width=0,height=0.5) +
  ggtitle('Milliseconds Per Step for First Ten Epochs: Not Accelerated') +
  ylab('')

grid.arrange(pspmsac, pspmsnac, ncol=2)
msps_plot <- arrangeGrob(pspmsac, pspmsnac, ncol=2)
ggsave('msperstep.png',msps_plot)

df_amd <- df_runtimes_accel %>% filter(Config != 'GeForce')
df_geforce <- df_runtimes_accel %>%  filter(Config == 'GeForce')
df_i7 <- df_runtimes_noac %>% filter(Config=='i7')
df_i9 <- df_runtimes_noac %>% filter(Config=='i9')
psacc_nvd <- ggplot(df_geforce, aes(x=Epoch,y=TrainAccuracy,color=Architecture, shape=Config)) + 
  geom_path() + 
  ggtitle('Training Accuracy: GeForce') +
  ylab('Training Accuracy')

psacc_amd <- ggplot(df_amd, aes(x=Epoch,y=TrainAccuracy,color=Architecture, shape=Config)) + 
  geom_path() + 
  ggtitle('Radeon Pro') +
  ylab('') +
  xlab('')

psacc_i7 <- ggplot(df_i7, aes(x=Epoch,y=TrainAccuracy,color=Architecture, shape=Config)) + 
  geom_path() +
  ggtitle('i7') + 
    ylab('') +
    xlab('')

psacc_i9 <- ggplot(df_i9, aes(x=Epoch,y=TrainAccuracy,color=Architecture, shape=Config)) + 
  geom_path() + 
  ggtitle('i9') +
    ylab('') +
    xlab('')
  
  
grid.arrange(psacc_nvd,psacc_amd,psacc_i7,psacc_i9,nrow=2,ncol=2)
training_acc_plot <- arrangeGrob(psacc_nvd,psacc_amd,psacc_i7,psacc_i9,nrow=2,ncol=2)
ggsave('trainingacc.png',training_acc_plot)

  
psacc_nvd_v <- ggplot(df_geforce, aes(x=Epoch,y=ValidationAccuracy,color=Architecture, shape=Config)) + 
  geom_path() + 
  ggtitle('Validation Accuracy: GeForce') +
  ylab('Validation Accuracy')

psacc_amd_v <- ggplot(df_amd, aes(x=Epoch,y=ValidationAccuracy,color=Architecture, shape=Config)) + 
  geom_path() + 
  ggtitle('Radeon Pro') +
  ylab('') +
  xlab('')

psacc_i7_v <- ggplot(df_i7, aes(x=Epoch,y=ValidationAccuracy,color=Architecture, shape=Config)) + 
  geom_path() +
  ggtitle('i7') + 
  ylab('') +
  xlab('')

psacc_i9_v <- ggplot(df_i9, aes(x=Epoch,y=ValidationAccuracy,color=Architecture, shape=Config)) + 
  geom_path() + 
  ggtitle('i9') +
  ylab('') +
  xlab('')  
grid.arrange(psacc_nvd_v,psacc_amd_v,psacc_i7_v,psacc_i9_v,nrow=2,ncol=2)
val_acc_plot <- arrangeGrob(psacc_nvd_v,psacc_amd_v,psacc_i7_v,psacc_i9_v,nrow=2,ncol=2)
ggsave('valacc.png',val_acc_plot)
